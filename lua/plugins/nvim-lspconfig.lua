local config = function()
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

  -- Python LSP
  local pyrightCapabilities = vim.lsp.protocol.make_client_capabilities()
  pyrightCapabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 } 
  require("lspconfig").pyright.setup{
    capabilities = pyrightCapabilities,
    settings = {
      pyright = {
        disableOrganizeImports = true, -- Using Ruff
      },
      python = {
        analysis = {
          ignore = { '*' }, -- Using Ruff
          typeCheckingMode = 'off', -- Using mypy
        },
      },
    },
  }

  -- Lua LSP
  require("lspconfig").lua_ls.setup{
    capabilities = capabilities,
  }

  -- C/C++ LSP
  require("lspconfig").clangd.setup{
    capabilities = capabilities
  }

  -- XML
  require("lspconfig").lemminx.setup {
    capabilities = capabilities
  }

  -- Swift setup
  require("lspconfig").sourcekit.setup{
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
            dynamicRegistration = true,
        },
      }
    }
  }
  -- Java LSP
  -- JAVA SETUP IS IN nvim-jdtls.lua FILE
  require("lspconfig").jdtls.setup{
    capabilities = capabilities
  }
end
return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
  dependencies = {
    "windwp/nvim-autopairs",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }
}
