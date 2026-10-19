require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, { desc = "Telescope fuzzy find in current buffer" })

vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to the implementation(s) of the word under the cursor" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Search all references of the word under the cursor" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to the definition of the word under the cursor or show all options if there are multiple" })
