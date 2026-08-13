local config = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Set default capabilities for all servers
  vim.lsp.config('*', { capabilities = capabilities })

  -- Setting visual diagnostic capabilities
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    signs = true,
    update_in_insert = false,
  })

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

  -- Matlab LSP
  vim.lsp.config('matlab_ls', {
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
          -- diagnosticSeverityOverrides = {
          --   reportUnusedVariable = "none",
          -- }
        },
      },
    },
  })

  require("conform").setup({
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" }
    }
  })
  -- Lua LSP
  vim.lsp.config('lua_ls', {})

  -- C/C++ LSP
  vim.lsp.config('clangd', {})

  -- Arduino LSP
  vim.lsp.config('arduino_language_server', {
    cmd = {
      'arduino-language-server',
      '-cli-config', vim.fn.expand('~/Library/Arduino15/arduino-cli.yaml'),
      '-cli', 'arduino-cli',
      '-clangd', 'clangd',
      '-fqbn', 'arduino:avr:uno',
    },
  })

  -- XML
  vim.lsp.config('lemminx', {})

  vim.lsp.enable({ 'texlab', 'pyright', 'lua_ls', 'clangd', 'lemminx', 'arduino_language_server' })

  -- Neovim 0.12+ has a builtin :lsp command, so nvim-lspconfig no longer
  -- defines :LspInfo — recreate it as an alias
  vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })
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
