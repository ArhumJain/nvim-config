-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Search
vim.o.ignorecase = true -- Case-insensitive search...
vim.o.smartcase = true -- ...unless the search has an uppercase letter, then match case exactly

-- Appearance
vim.o.relativenumber = true
vim.o.number = true
vim.o.termguicolors = true
vim.o.cmdheight = 0
vim.o.scrolloff = 10 -- Start scrolling once the cursor is 10 lines from the window edge
vim.o.signcolumn = "yes"
vim.o.numberwidth = 1
vim.o.showmode = false -- lualine already shows the mode
vim.o.cursorline = true

-- Behavior
vim.o.swapfile = false
vim.o.splitright = true -- Default new vertical splits to the right
vim.o.splitbelow = true -- Default new horizontal splits to below
vim.opt.iskeyword:append("-") -- Treat hyphenated words as a single word
vim.o.mouse = "a" -- Enable the mouse in all modes
vim.opt.clipboard:append("unnamedplus") -- Share the system clipboard for yank/paste
vim.o.completeopt = "menu,menuone,noselect"

if vim.g.neovide then
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animation_length = 0
end
