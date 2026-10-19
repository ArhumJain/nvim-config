-- Tracks the `main` branch, the actively maintained API for this plugin: there is no
-- single setup() call — parsers are installed with install(), and highlighting is
-- started per buffer via the FileType autocmd below.

local ensure_installed = {
  "c", "cpp", "python", "latex", "lua", "vim", "vimdoc", "query",
  "markdown", "markdown_inline", "gitignore",
}

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
