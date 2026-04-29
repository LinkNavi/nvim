local wk = require("which-key")

wk.add({
  -- Filesystem Group
  { "<leader>f", group = "Filesystem" },
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
  { "<leader>fe", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
  { "<leader>fo", "<cmd>Neotree reveal<CR>", desc = "Reveal File in Neo-tree" },
  { "<leader>fb", "<cmd>Telescope file_browser<CR>", desc = "File Browser" },
  { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
  { "<leader>fn", "<cmd>enew<CR>", desc = "New File" },
  { "<leader>fw", "<cmd>w<CR>", desc = "Write File" },
  { "<leader>fd", "<cmd>call delete(expand('%')) | bdelete!<CR>", desc = "Delete File" },
  { "<leader>fp", "<cmd>echo expand('%:p')<CR>", desc = "Print File Path" },
  { "<leader>fc", "<cmd>cd %:p:h<CR>", desc = "Change Directory to File" },
  { "<leader>fs", "<cmd>Telescope grep_string<CR>", desc = "Search String" },



  -- LSP Operations
  { "<leader>l", group = "LSP" },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
  { "<leader>ld", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format" },
  { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
  { "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace Symbols" },
  { "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show Diagnostics" },
  { "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
  { "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev Diagnostic" },
  { "<leader>lR", "<cmd>Telescope lsp_references<CR>", desc = "References" },

  { "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show Diagnostic" },

 { "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Diagnostic List" },
  -- Terminal
  { "<leader>t", group = "Terminal" },
  { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Floating Terminal" },
  { "<leader>tv", "<cmd>vsplit | terminal<CR>", desc = "Vertical Terminal" },
  { "<leader>th", "<cmd>split | terminal<CR>", desc = "Horizontal Terminal" },


  -- Themes & UI
  { "<leader>T", group = "Themes & UI" },
  { "<leader>Tt", "<cmd>Themery<CR>", desc = "Theme Picker" },
  { "<leader>Ts", "<cmd>Telescope colorscheme<CR>", desc = "Select Colorscheme" },
  { "<leader>Tn", "<cmd>set number!<CR>", desc = "Toggle Line Numbers" },
  { "<leader>Tr", "<cmd>set relativenumber!<CR>", desc = "Toggle Relative Numbers" },
  { "<leader>Tw", "<cmd>set wrap!<CR>", desc = "Toggle Word Wrap" },
  { "<leader>Tc", "<cmd>ColorizerToggle<CR>", desc = "Toggle Colorizer" },
  { "<leader>Td", "<cmd>set background=dark<CR>", desc = "Dark Background" },
  { "<leader>Tl", "<cmd>set background=light<CR>", desc = "Light Background" },
  { "<leader>Tb", "<cmd>TransparentToggle<CR>", desc = "Toggle Transparency" },

  -- Configuration
  { "<leader>c", group = "Config" },
  { "<leader>cv", "<cmd>e $MYVIMRC<CR>", desc = "Edit Neovim Config" },
  { "<leader>cp", "<cmd>e ~/.config/nvim/lua/plugins/<CR>", desc = "Edit Plugins" },
  { "<leader>ck", "<cmd>e ~/.config/nvim/lua/keymaps/keys.lua<CR>", desc = "Edit Keymaps" },
  { "<leader>cs", "<cmd>source %<CR>", desc = "Source Current File" },
  { "<leader>cr", "<cmd>source $MYVIMRC<CR>", desc = "Reload Config" },
  { "<leader>ch", "<cmd>checkhealth<CR>", desc = "Check Health" },
  { "<leader>cm", "<cmd>messages<CR>", desc = "Show Messages" },
  { "<leader>ci", "<cmd>LspInfo<CR>", desc = "LSP Info" },
  { "<leader>cR", "<cmd>LspRestart<CR>", desc = "Restart LSP" },
  { "<leader>cu", "<cmd>Lazy update<CR>", desc = "Update Plugins" },
  { "<leader>cS", "<cmd>Lazy sync<CR>", desc = "Sync Plugins" },


})
