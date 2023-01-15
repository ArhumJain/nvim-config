-- Call this file first

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.o.syntax = true

vim.o.relativenumber = true
vim.o.number = true
vim.o.hidden = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.wo.wrap = false

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.hlsearch = false

vim.o.showcmd = true

vim.o.splitbelow = true

vim.o.mouse = 'a'

vim.o.backup = false
vim.o.writebackup = false
vim.o.laststatus = 2
vim.o.termguicolors = true


vim.o.termguicolors = true
vim.o.background = 'dark'
vim.g.gruvbox_italicize_comments = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd "colorscheme codedark"
vim.g.neovide_refresh_rate = 144

vim.keymap.set('i', 'jj', '<Esc>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.o.completeopt = 'menuone,noselect'


vim.g.presence_log_level = 'debug'

require("nvim-autopairs").setup{}
require('c_comment')
require('c_telescope')
require('c_lsp')
require('c_complete')
require('c_treesitter')
require('c_lualine')
require('c_bufferline')
require('c_tree')
require('c_presence')

