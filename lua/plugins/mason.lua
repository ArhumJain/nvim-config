local config = function()
  -- By mason-lspconfig documenation, load mason first, then mason-lspconfig then setup lspconfig.nvim servers
  require("mason").setup()
  require("mason-lspconfig").setup()

  -- local capabilities = require("cmp_nvim_lsp").default_capabilities() -- Every language server from lspconfig has to attach to cmp for autocompletion
  --
  -- -- Latex LSP
  -- require("lspconfig").texlab.setup{
  --   capabilities = capabilities,
  --   settings = {
  --     texlab = {
  --       build = {
  --         onSave = true
  --       }
  --     }
  --   }
  -- }
  --
  -- require("lspconfig").pyright.setup{
  --   capabilities = capabilities,
  -- }
end

return {
  "williamboman/mason.nvim",
  config = config,
  lazy = false
}
