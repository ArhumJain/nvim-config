-- Leader must be set before plugins and keymaps load.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("plugins")
require("keymaps")
require("lsp")
require("commands")
