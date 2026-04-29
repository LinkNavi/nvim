if not vim.g.neovide then return end

-- Window
vim.g.neovide_opacity = 0.92
vim.g.neovide_normal_opacity = 0.92
vim.g.neovide_window_blurred = true

-- Padding
vim.g.neovide_padding_top = 12
vim.g.neovide_padding_bottom = 12
vim.g.neovide_padding_left = 16
vim.g.neovide_padding_right = 16

-- Font defined in the neovide toml
--vim.o.guifont = "JetBrainsMono Nerd Font:h13"

-- Cursor
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.4
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_opacity = 180.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
vim.g.neovide_cursor_vfx_particle_density = 7.0
vim.g.neovide_cursor_vfx_particle_speed = 10.0

-- Scroll
vim.g.neovide_scroll_animation_length = 0.25
vim.g.neovide_scroll_animation_far_lines = 1

-- Floating shadow
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
vim.g.neovide_floating_blur_amount_x = 4.0
vim.g.neovide_floating_blur_amount_y = 4.0

-- Refresh rate
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5

-- Misc
vim.g.neovide_confirm_quit = true
vim.g.neovide_detach_on_quit = "prompt"
vim.g.neovide_remember_window_size = true

-- Keymaps
vim.keymap.set("n", "<C-=>", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) * 1.1
end, { desc = "Zoom in" })

vim.keymap.set("n", "<C-->", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) / 1.1
end, { desc = "Zoom out" })

vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1
end, { desc = "Zoom reset" })

-- Clipboard passthrough
vim.keymap.set({ "n", "v" }, "<C-S-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-S-v>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("i", "<C-S-v>", '<C-r>+', { desc = "Paste from system clipboard (insert)" })
