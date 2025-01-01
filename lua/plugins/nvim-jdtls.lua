return {
  "mfussenegger/nvim-jdtls",
  lazy = false,
  config = function()
    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)
    local config = {
      capabilities = capabilities,
      cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
      root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    }
    -- require("jdtls").start_or_attach(config)
  end
}
