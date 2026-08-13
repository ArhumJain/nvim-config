local config = function()
  -- By mason-lspconfig documentation, load mason first, then mason-lspconfig, then lspconfig servers
  require("mason").setup({})
  require("mason-lspconfig").setup({
                                                                             -- Ruff is for better python support --
    ensure_installed = { "texlab", "pyright", "lua_ls", "clangd", "lemminx", "ruff", "arduino_language_server" },
    automatic_installation = true,
    automatic_enable = false,

  })
end

return {
  "williamboman/mason.nvim",
  config = config,
  lazy = false
}
