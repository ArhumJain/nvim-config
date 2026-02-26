local config = function()
  -- By mason-lspconfig documentation, load mason first, then mason-lspconfig, then lspconfig servers
  require("mason").setup({})
  require("mason-lspconfig").setup({
    ensure_installed = { "texlab", "pyright", "lua_ls", "clangd", "lemminx" },
    automatic_installation = true,
  })
end

return {
  "williamboman/mason.nvim",
  config = config,
  lazy = false
}
