return {
  'CosmicNvim/cosmic-ui',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('cosmic-ui').setup({
      rename = {
        border = {
          highlight = 'FloatBorder',
          style = 'rounded',
          title = ' Rename ',
          title_align = 'left',
          title_hl = 'FloatBorder',
        },
      },
    })

    vim.keymap.set('n', 'gn', require('cosmic-ui').rename, { desc = 'Rename symbol' })
    vim.keymap.set('n', 'ga', require('cosmic-ui').code_actions, { desc = 'Code actions' })
    vim.keymap.set('v', 'ga', require('cosmic-ui').range_code_actions, { desc = 'Range code actions' })
  end,
}
