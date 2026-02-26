-- lua/plugins/build.lua
return {
  "akinsho/toggleterm.nvim",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local terminals = {}

    -- Build status for lualine
    _G.build_status = { state = "idle", icon = "󰚩", color = "#7aa2f7" }

    local function set_status(state)
      if state == "running" then
        _G.build_status = { state = "running", icon = "󰑮 Building...", color = "#ECBE7B" }
      elseif state == "success" then
        _G.build_status = { state = "success", icon = "󰸞 OK", color = "#98be65" }
      elseif state == "failure" then
        _G.build_status = { state = "failure", icon = "󰅚 Failed", color = "#ec5f67" }
      else
        _G.build_status = { state = "idle", icon = "󰚩", color = "#7aa2f7" }
      end
      -- force lualine redraw
      pcall(function() require("lualine").refresh() end)
    end

    local function get_project_root()
      return vim.fn.getcwd()
    end

    local function get_script(name)
      local path = get_project_root() .. "/.nvim/" .. name .. ".sh"
      if vim.fn.filereadable(path) == 1 then
        return path
      end
      vim.notify("No .nvim/" .. name .. ".sh found", vim.log.levels.WARN)
      return nil
    end

    -- Parse build output into quickfix
    local function parse_to_quickfix(output_lines)
      local qf_items = {}
      for _, line in ipairs(output_lines) do
        -- matches: file.c:10:5: error: message
        local file, lnum, col, kind, msg = line:match("^(.+):(%d+):(%d+):%s*(error|warning|note):%s*(.+)$")
        if file then
          table.insert(qf_items, {
            filename = file,
            lnum = tonumber(lnum),
            col = tonumber(col),
            text = msg,
            type = kind == "error" and "E" or kind == "warning" and "W" or "I",
          })
        end
        -- also catch Vulkan validation layer format
        -- "VUID-xxx | MessageID = 0x... | message"
        local vk_msg = line:match("^.-(VUID%-.+)$")
        if vk_msg then
          table.insert(qf_items, {
            filename = "[Vulkan]",
            lnum = 1,
            col = 1,
            text = vk_msg,
            type = "E",
          })
        end
      end
      if #qf_items > 0 then
        vim.fn.setqflist(qf_items, "r")
        vim.cmd("copen")
        vim.notify(#qf_items .. " issue(s) found", vim.log.levels.WARN)
      else
        vim.fn.setqflist({}, "r")
      end
    end

    local function run_script(name)
      local script = get_script(name)
      if not script then return end

      if terminals[name] then
        terminals[name]:shutdown()
      end

      local output_lines = {}
      set_status("running")

      terminals[name] = Terminal:new({
        cmd = "bash " .. script .. " 2>&1",
        direction = "horizontal",
        close_on_exit = false,
        on_stdout = function(_, _, data)
          if data then
            for _, line in ipairs(data) do
              if line ~= "" then
                table.insert(output_lines, line)
              end
            end
          end
        end,
        on_exit = function(_, _, code)
          if name == "build" then
            parse_to_quickfix(output_lines)
            if code == 0 then
              set_status("success")
              vim.notify("Build succeeded ✓", vim.log.levels.INFO)
            else
              set_status("failure")
              vim.notify("Build failed ✗", vim.log.levels.ERROR)
            end
          else
            if code == 0 then
              vim.notify(name .. " succeeded ✓", vim.log.levels.INFO)
            else
              vim.notify(name .. " failed ✗", vim.log.levels.ERROR)
            end
          end
        end,
      })
      terminals[name]:toggle()
    end

    -- Serial monitor — connects to a serial port or pty
    local serial_term = nil
    local function open_serial(port, baud)
      port = port or "/dev/ttyUSB0"
      baud = baud or "115200"
      -- for QEMU use: socat - /tmp/qemu-serial
      local cmd = vim.fn.executable("socat") == 1
        and ("socat - " .. port)
        or ("screen " .. port .. " " .. baud)

      if serial_term then serial_term:shutdown() end
      serial_term = Terminal:new({
        cmd = cmd,
        direction = "vertical",
        close_on_exit = false,
        display_name = "Serial Monitor",
      })
      serial_term:toggle()
    end

    -- Man page opener
    local function open_man()
      local word = vim.fn.expand("<cword>")
      -- try section 2 (syscalls) first, then 3 (libc), then default
      local sections = { "2", "3", "" }
      for _, sec in ipairs(sections) do
        local cmd = sec ~= "" and ("man " .. sec .. " " .. word) or ("man " .. word)
        local result = vim.fn.system("man -w " .. (sec ~= "" and (sec .. " ") or "") .. word .. " 2>/dev/null")
        if result ~= "" then
          Terminal:new({
            cmd = cmd,
            direction = "float",
            close_on_exit = true,
            float_opts = {
              border = "rounded",
              width = math.floor(vim.o.columns * 0.85),
              height = math.floor(vim.o.lines * 0.85),
            },
          }):toggle()
          return
        end
      end
      vim.notify("No man page found for: " .. word, vim.log.levels.WARN)
    end

    -- List and pick any script
    local function list_scripts()
      local dir = get_project_root() .. "/.nvim/"
      local scripts = vim.fn.glob(dir .. "*.sh", false, true)
      if #scripts == 0 then
        vim.notify("No scripts found in .nvim/", vim.log.levels.WARN)
        return
      end
      local items = {}
      for _, path in ipairs(scripts) do
        table.insert(items, path:match("([^/]+)%.sh$"))
      end
      vim.ui.select(items, { prompt = "Run script:" }, function(choice)
        if choice then run_script(choice) end
      end)
    end

    -- Keymaps
    vim.keymap.set("n", "<leader>mb", function() run_script("build") end, { desc = "Build" })
    vim.keymap.set("n", "<leader>mr", function() run_script("run") end,   { desc = "Run" })
    vim.keymap.set("n", "<leader>mt", function() run_script("test") end,  { desc = "Test" })
    vim.keymap.set("n", "<leader>ml", list_scripts,                        { desc = "List Scripts" })
    vim.keymap.set("n", "<leader>ms", function()
      vim.ui.input({ prompt = "Serial port (default /dev/ttyUSB0): " }, function(port)
        open_serial(port ~= "" and port or nil)
      end)
    end, { desc = "Serial Monitor" })

    -- ]q and [q jump to next/prev quickfix error
    vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz",     { desc = "Next error" })
    vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz",     { desc = "Prev error" })
    vim.keymap.set("n", "<leader>mq", "<cmd>copen<CR>", { desc = "Open error list" })

    -- md opens man page for word under cursor
    vim.keymap.set("n", "md", open_man, { desc = "Open man page" })
  end,
}
