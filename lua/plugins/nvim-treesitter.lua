-- Uses the `main` branch — the old `master` branch is archived and crashes on Neovim 0.12+
-- (e.g. in LSP hover windows). API is completely different: no `configs.setup()`;
-- parsers are installed with `install()` and highlighting is started per-buffer.

local ensure_installed = {
  "c", "cpp", "java", "python", "latex", "lua", "vim", "vimdoc", "query",
  "markdown", "markdown_inline", "gitignore",
}

local config = function()
  local ts = require("nvim-treesitter")

  -- Install any missing parsers from the list (async, no-op when already installed)
  ts.install(ensure_installed)

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)

      -- latex highlighting is controlled by VimTeX
      if not lang or lang == "latex" then
        return
      end

      if vim.treesitter.language.add(lang) then
        vim.treesitter.start(args.buf, lang)
      elseif vim.list_contains(ts.get_available(), lang) then
        -- Parser not installed yet: install it, then enable highlighting
        ts.install(lang):await(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end)
      end
    end,
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = config,
}
