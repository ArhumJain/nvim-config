local config = function()
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  vim.opt.completeopt = "menu,menuone,noselect"

  cmp.setup({
    snippet = {
      expand = function(args) 
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-k>'] = cmp.mapping.select_prev_item(), -- Previous suggestion
      ['<C-j>'] = cmp.mapping.select_next_item(), -- Next item
    }),
   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" }, -- lsp
      { name = "luasnip" }, -- snippets
      -- { name = "buffer" }, -- Text within the buffer
      -- { name = "path" }, -- File system paths
    }),
  })

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end

return {
  "hrsh7th/nvim-cmp",
  config = config,
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  }
}
