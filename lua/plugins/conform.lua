require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
  },
})

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format()
end, { desc = "Format buffer" })

