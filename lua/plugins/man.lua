-- ~/.config/nvim/lua/plugins/cppman.lua
return {
  "madskjeldgaard/cppman.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    local cppman = require("cppman")
    cppman.setup()

    -- Open cppreference in a floating buffer
    vim.keymap.set("n", "<C-r>", function()
      cppman.open_cppman_for(vim.fn.expand("<cword>"))
    end, { desc = "Open cppreference for symbol" })
  end,
}
