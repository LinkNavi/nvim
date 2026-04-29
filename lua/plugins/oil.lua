return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      default_file_explorer = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      columns = {
        { 'icon', highlight = 'Directory' },
        { 'permissions', highlight = 'Comment' },
        { 'size', highlight = 'Number' },
        { 'mtime', highlight = 'Comment' },
      },
      win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
      },
      float = {
        padding = 4,
        max_width = 0.9,
        max_height = 0.9,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
      },
      preview = {
        max_width = 0.6,
        min_width = 0.4,
        border = 'rounded',
      },
      keymaps = {
        ['g?']     = 'actions.show_help',
        ['<CR>']   = 'actions.select',
        ['<C-v>']  = 'actions.select_vsplit',
        ['<C-h>']  = 'actions.select_split',
        ['<C-p>']  = 'actions.preview',
        ['<C-c>']  = 'actions.close',
        ['<BS>']   = 'actions.parent',
        ['_']      = 'actions.open_cwd',
        ['`']      = 'actions.cd',
        ['~']      = 'actions.tcd',
        ['gs']     = 'actions.change_sort',
        ['gx']     = 'actions.open_external',
        ['g.']     = 'actions.toggle_hidden',
        ['g\\']    = 'actions.toggle_trash',
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
        natural_order = true,
        sort = {
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
      },
    })

    vim.keymap.set('n', '<leader>e', function()
      require('oil').open_float()
    end, { desc = 'Oil file explorer' })

    vim.keymap.set('n', '<leader>E', function()
      require('oil').open_float(vim.fn.getcwd())
    end, { desc = 'Oil cwd' })
  end,
}
