vim.keymap.set("i", "jj", "<Esc>", { silent = true })

-- Move by display line, unless a count is given, then move by real lines
vim.keymap.set("n", "j", "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set("n", "k", "v:count ? 'k' : 'gk'", { expr = true })
