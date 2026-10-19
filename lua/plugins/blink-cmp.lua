require("blink.cmp").setup({
  -- preset = "none": keys are listed out explicitly so blink binds nothing beyond
  -- these seven. <C-e> and <C-k> both end in "fallback", so whenever the menu is
  -- closed they fall through to LuaSnip's choice-cycling and snippet expand instead
  -- (the default preset's <C-k> runs signature help first, which would consume the
  -- key and never reach LuaSnip).
  keymap = {
    preset = "none",
    ["<Tab>"] = { "select_and_accept", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-Space>"] = { "show" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },

  snippets = { preset = "luasnip" },

  sources = {
    default = { "lsp", "snippets", "path" },
  },

  completion = {
    menu = {
      border = "rounded",
      -- The menu defaults to Pmenu, which kanagawa colors a blue that clashes with
      -- the dragon background. Use the float colors so it matches the docs window.
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      auto_show = true,
      window = { border = "rounded" },
    },
  },

  -- Command-line completion is off by default here: the old cmp setup never called
  -- cmp.setup.cmdline(), so `:` and `/` used Neovim's native wildmenu.
  cmdline = { enabled = false },
})
