-- ~/.config/nvim/lua/plugins/luasnip.lua
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "v2.*", -- follow latest v2 release
    build = "make install_jsregexp", -- optional: for regex support in snippets
    config = function()
      local luasnip = require("luasnip")

      -- load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- optional: load your own custom snippets
      -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

      luasnip.config.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- keymaps for jumping through snippet placeholders
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true, desc = "Luasnip expand or jump" })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true, desc = "Luasnip jump back" })

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, { silent = true, desc = "Luasnip next choice" })
    end,
  },
}
