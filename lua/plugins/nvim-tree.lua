-- nvim-tree requires netrw disabled; do this before netrw would load.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sync_root_with_cwd = true,
  filters = {
    git_ignored = false, -- show git-ignored files
  },
  renderer = {
    highlight_git = "name", -- mark files by git status (ignored files get dimmed + ◌ icon)
  },
})

vim.keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
