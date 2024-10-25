-- These are vim configurations (vim.o.*, vim.opt.*)
local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = true


-- Search
opt.incsearch = true
opt.ignorecase = true -- When searching, highlight uppercase as well even if entry is lower
opt.smartcase = true -- When searching, if entry has upper case, then ONLY highlight uppercase
opt.hlsearch = true -- Highlight search terms

-- Appearance
opt.relativenumber = true
opt.number = true
opt.termguicolors = true -- Full colors for plugins takign advantage of it
opt.cmdheight = 1
opt.scrolloff = 10 -- If 10 lines away from bottom, then start scrolling
opt.completeopt = "menuone,noinsert,noselect" -- REVIEW THESE LATER
opt.signcolumn = "yes"
opt.numberwidth = 1
opt.showmode = false -- Since we have lualine, no need to show default mode indicator
opt.cmdheight = 0

-- Behavior
opt.hidden = true -- Edit buffers without having to save`
opt.errorbells = false
opt.swapfile = false
opt.backspace = "indent,eol,start"
opt.splitright = true -- Default new pane to the right
opt.splitbelow = true -- Default new pane to below
opt.autochdir = false -- Prevent changing workspace directory everytime directory is changed
opt.iskeyword:append("-") -- Allows hyphenated words to be counted as a word
opt.mouse:append('a') -- Mouse always available in any mode
opt.clipboard:append("unnamedplus") -- Allows up to paste copies from outside of vim
opt.modifiable = true -- You can edit buffer you're in by default
opt.encoding = "UTF-8"
opt.completeopt = "menu,menuone,noselect"






