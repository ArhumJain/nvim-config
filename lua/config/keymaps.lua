-- Custom keybindings
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

-- Allows us to vertically move through wrapped lines
vim.cmd("nnoremap <expr> j v:count ? 'j' : 'gj'")
vim.cmd("nnoremap <expr> k v:count ? 'k' : 'gk'")

-- Navigation between panes (Uncomment only if vim-tmux-navigator is not used as these override the mappins from that)

-- vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true})
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true})
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true})
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true})

-- nvim-tree
vim.keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true})
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to the implementation(s) of the word under the cursor"})
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Search all references of the word under the cursor"})
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to the definition of the word under the cursor or show all options if there are multiple"})

