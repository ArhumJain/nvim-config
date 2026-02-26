local config = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Set default capabilities for all servers
  vim.lsp.config('*', { capabilities = capabilities })

  -- Latex LSP
  vim.lsp.config('texlab', {
    settings = {
      texlab = {
        build = {
          onSave = true
        }
      }
    }
  })

  -- Python LSP
  local pyrightCapabilities = vim.lsp.protocol.make_client_capabilities()
  pyrightCapabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
  vim.lsp.config('pyright', {
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
  })

  -- Lua LSP
  vim.lsp.config('lua_ls', {})

  -- C/C++ LSP
  vim.lsp.config('clangd', {})

  -- XML
  vim.lsp.config('lemminx', {})

  vim.lsp.enable({ 'texlab', 'pyright', 'lua_ls', 'clangd', 'lemminx' })
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
