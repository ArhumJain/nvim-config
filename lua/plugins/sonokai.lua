return {
  "sainnhe/sonokai",
  priority = 1000,
  lazy = false,
  config = function ()
    vim.g.sonokai_enable_italic = true
    -- vim.g.sonokai_style = "default"
    vim.g.sonokai_better_performance = true
    vim.opt.termguicolors = true
    vim.cmd.colorscheme('sonokai')
  
  end
}
