-- mason first, then mason-lspconfig, per mason-lspconfig's documented load order
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "texlab", "pyright", "lua_ls", "clangd", "lemminx", "ruff", "arduino_language_server" },
  -- lua/lsp.lua enables servers explicitly via vim.lsp.enable(), so automatic
  -- enabling here would be redundant and could race with it
  automatic_enable = false,
})
