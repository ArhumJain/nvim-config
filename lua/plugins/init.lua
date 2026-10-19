-- To add a plugin: add its URL to the vim.pack.add() call below. If it needs
-- setup() or keymaps, create lua/plugins/<name>.lua with that code and add a
-- `require("plugins.<name>")` line at the bottom of this file.
-- To remove a plugin: delete it from all three of those places, then run
-- `:lua vim.pack.del({ "<name>" })` and restart.

-- Hooks must be registered before the first vim.pack.add() call below, or
-- they will not fire on a fresh install.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == "LuaSnip" and (kind == "install" or kind == "update") then
      -- Optional native regex support; needs a C compiler. Wrapped in pcall
      -- and never waited on, so a missing compiler or `make` can't break startup.
      pcall(vim.system, { "make", "install_jsregexp" }, { cwd = ev.data.path })
    end

    if name == "cord.nvim" and (kind == "install" or kind == "update") then
      -- :Cord update downloads the prebuilt presence server; the command is
      -- defined by the plugin itself, so make sure it's loaded first.
      if not ev.data.active then
        vim.cmd.packadd("cord.nvim")
      end
      vim.cmd("Cord update")
    end

    if name == "nvim-treesitter" and kind == "update" then
      require("nvim-treesitter").update()
    end
  end,
})

vim.pack.add({
  -- colorscheme
  "https://github.com/rebelot/kanagawa.nvim",

  -- shared dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- UI
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-tree.lua",

  -- fuzzy finding & navigation
  "https://github.com/nvim-telescope/telescope.nvim",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/folke/flash.nvim",

  -- editing
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/nemanjamalesija/smart-paste.nvim",

  -- git & tmux
  "https://github.com/kdheepak/lazygit.nvim",
  "https://github.com/christoomey/vim-tmux-navigator",

  -- completion & snippets
  { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.x") },
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.x") },

  -- LaTeX
  "https://github.com/lervag/vimtex",
  "https://github.com/let-def/texpresso.vim",

  -- Discord presence
  -- "https://github.com/vyfor/cord.nvim",

  -- treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

  -- LSP & tooling
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/stevearc/conform.nvim",
})

require("plugins.kanagawa")
require("plugins.lualine")
require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.flash")
require("plugins.indent-blankline")
require("plugins.nvim-autopairs")
require("plugins.lazygit")
require("plugins.vim-tmux-navigator")
require("plugins.nvim-treesitter")
require("plugins.luasnip")
require("plugins.blink-cmp")
require("plugins.texpresso")
require("plugins.cord")
require("plugins.mason")
require("plugins.conform")
