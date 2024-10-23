local config = function()
  
  local lspconfig = require("lspconfig")

  local capabilities = require("cmp_nvim_lsp").default_capabilities() -- Every language server from lspconfig has to attach to cmp for autocompletion

  -- Latex LSP
  require("lspconfig").texlab.setup{
    capabilities = capabilities,
    settings = {
      texlab = {
        build = {
          onSave = true
        }
      }
    }
  }

  require("lspconfig").pyright.setup{
    capabilities = capabilities,
  }
end
return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
  dependencies = {
    "windwp/nvim-autopairs",
    "williamboman/mason.nvim",
  }
}
