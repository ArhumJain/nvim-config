return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    -- vim.g.vimtex_view_method = "zathura"
    -- VimTeX highlight groups
    vim.api.nvim_set_hl(0, 'texCmd', { fg = '#ad3da4', bg = 'NONE', ctermfg = 127, ctermbg = 'NONE', cterm = {} })
    vim.api.nvim_set_hl(0, 'texMathEnvArgName', { link = 'texEnvArgName' })
    vim.api.nvim_set_hl(0, 'texMathZone', { link = 'LocalIdent' })
    vim.api.nvim_set_hl(0, 'texMathZoneEnv', { link = 'texMathZone' })
    vim.api.nvim_set_hl(0, 'texMathZoneEnvStarred', { link = 'texMathZone' })
    vim.api.nvim_set_hl(0, 'texMathZoneX', { link = 'texMathZone' })
    vim.api.nvim_set_hl(0, 'texMathZoneXX', { link = 'texMathZone' })
    vim.api.nvim_set_hl(0, 'texMathZoneEnsured', { link = 'texMathZone' })

    -- Small tweaks
    vim.api.nvim_set_hl(0, 'QuickFixLine', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'qfLineNr', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { link = 'LineNr' })
    vim.api.nvim_set_hl(0, 'Conceal', { link = 'LocalIdent' })
  end
}
