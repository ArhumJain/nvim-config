if vim.g.neovide then
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animation_length = 0
end


vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nvim Tree Requires the built-in netrw plugin be disabled
vim.g.loaded_netrw = 1 -- Tricks vim into thinking the plugin is already loaded so it doesnt ACTUALLY load it
vim.g.loaded_netrwPlugin = 1
