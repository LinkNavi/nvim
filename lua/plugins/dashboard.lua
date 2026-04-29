return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		local oldfiles = vim.v.oldfiles
		local dirs = {}
		local seen = {}
		for _, f in ipairs(oldfiles) do
			local dir = vim.fn.fnamemodify(f, ':h')
			if not seen[dir] and vim.fn.isdirectory(dir) == 1 then
				seen[dir] = true
				table.insert(dirs, dir)
				if #dirs >= 5 then break end
			end
		end

		local center = {}

		for i, dir in ipairs(dirs) do
			local short = vim.fn.fnamemodify(dir, ':~')
			local padded = ('󰉋 ' .. short .. string.rep(' ', math.max(0, 48 - #short)))
			table.insert(center, {
				icon = '',
				icon_hl = 'Comment',
				desc = padded,
				desc_hl = 'Directory',
				key = tostring(i),
				key_hl = 'Number',
				key_format = ' [%s]',
				action = 'lua vim.fn.chdir("' .. dir .. '") vim.cmd("Neotree reveal")',
			})
			vim.keymap.set('n', '<C-' .. i .. '>', function()
				vim.fn.chdir(dir)
require('oil').open_float(dir)
				vim.notify('cwd: ' .. dir, vim.log.levels.INFO)
			end, { desc = 'Open folder: ' .. dir })
		end

		table.insert(center, {
			icon = ' ',
			icon_hl = 'Title',
			desc = 'Open Folder                                         ',
			desc_hl = 'String',
			key = 'o',
			key_hl = 'Number',
			key_format = ' [%s]',
			action = function()
				vim.ui.input({ prompt = 'Folder path: ', completion = 'dir' }, function(input)
					if not input or input == '' then return end
					local path = vim.fn.expand(input)
					if vim.fn.isdirectory(path) == 0 then
						vim.notify('Not a directory: ' .. path, vim.log.levels.ERROR)
						return
					end
					vim.fn.chdir(path)
					vim.cmd('Neotree reveal')
				end)
			end,
		})

		table.insert(center, {
			icon = ' ',
			icon_hl = 'Title',
			desc = 'Quit                                                ',
			desc_hl = 'String',
			key = 'q',
			key_hl = 'Number',
			key_format = ' [%s]',
			action = 'qa',
		})

		require('dashboard').setup {
			theme = 'doom',
			config = {
				header = {
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡇⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠘⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀",
					"⢸⣿⣿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⡿⠀⠀⠀⠀⠀⠀⢠⠾⠿⠿⠿⠿⠿⠿⠿⠿⢦⡀⠀⠀⠀⠀⠀⠹⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣿⣿⡿",
					"⠀⢻⣿⣿⣿⣿⣿⣿⣶⣤⣀⡀⠀⠀⣰⣿⣿⣿⠃⠀⠀⠀⠀⠀⣴⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣹⡀⠀⠀⠀⠀⠀⢿⣿⣿⣧⠀⠀⠀⣀⣠⣴⣾⣿⣿⣿⣿⣿⣿⠁",
					"⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⡿⠀⠀⠀⠀⠀⣼⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣷⡀⠀⠀⠀⠀⢸⣿⣿⣿⣧⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀",
					"⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢀⣼⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⡄⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀",
					"⠀⠀⠀⠈⠙⠛⠛⠛⠛⠿⠿⠿⣿⣿⣿⣿⣿⡇⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⡄⠀⠀⢀⣿⣿⣿⣿⣿⡿⠿⠿⠛⠛⠛⠛⠛⠉⠀⠀⠀",
					"⠀⠀⢀⣀⣀⣠⣤⣤⣤⣶⣶⣶⣿⣿⣿⣿⣿⣷⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⢸⣿⣿⣿⣿⣿⣷⣶⣶⣦⣤⣤⣤⣀⣀⣀⠀⠀",
					"⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
					"⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇",
					"⠀⠘⣿⣿⣿⣿⣿⡿⠿⠛⠋⣁⣴⣾⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⢀⣾⣿⣿⡄⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⠉⠛⠻⠿⣿⣿⣿⣿⣿⡏⠀",
					"⠀⠀⠘⠛⠛⠉⠁⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⣼⣿⣿⣿⣷⡀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠉⠙⠛⠋⠀⠀",
					"⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⡿⠋⣸⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣯⠈⠻⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⡿⠋⠀⣰⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣧⠀⠈⢻⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⡿⠋⠀⠀⣠⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣷⠀⠀⠙⢿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⢰⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣧⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠁⠀⠀⣠⣶⣦⠀⠀⠀⠈⢻⣿⣿⠉⠀⠀⠀⢠⣶⣦⡀⠀⠀⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⠟⠁⠀⠀⠀⣀⣸⣿⣿⣀⡀⠀⠀⠀⠻⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡿⠟⠁⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠈⠛⢿⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⣶⣶⣤⣀⡀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⣀⣤⣴⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡟⠛⠛⠛⠻⣿⣿⡆⠀⠀⠸⣿⣿⣿⣿⣿⡟⠀⠀⢀⣾⣿⠿⠛⠛⠛⢻⣿⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⡄⠀⠀⠀⠈⠛⠃⠀⠀⠀⢻⣿⣿⣿⣿⠁⠀⠀⠈⠛⠃⠀⠀⠀⠀⣼⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣈⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				},
				center = center,
				footer = {
					'',
					'Why are you buying clothes from the soup store?',
					'',
				},
				vertical_center = true,
			}
		}
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dashboard",
			callback = function()
				vim.opt_local.showtabline = 0
			end,
		})
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
