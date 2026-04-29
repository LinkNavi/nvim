-- ~/.config/nvim/lua/plugins/diagnostics.lua
return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●", -- or "■", "▎", "x"
        spacing = 4,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Diagnostic keymaps

    -- Ctrl+Shift+D for next diagnostic, Ctrl+Shift+F for previous
vim.keymap.set("n", "<C-S-D>", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<C-S-F>", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

  end,
}
