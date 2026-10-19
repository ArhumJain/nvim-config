vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
  signs = true,
  update_in_insert = false,
})

vim.lsp.enable({
  "texlab",
  "pyright",
  "ruff",
  "lua_ls",
  "clangd",
  "lemminx",
  "arduino_language_server",
})

-- Neovim's builtin LSP has no :LspInfo command; :checkhealth vim.lsp is the
-- equivalent, so keep the familiar name around as an alias.
vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", { desc = "Alias to `:checkhealth vim.lsp`" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
