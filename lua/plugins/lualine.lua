local config = function()
  require('lualine').setup {
    options = {
      theme = "sonokai",
      globalstatus = true,
      -- section_separators = { left = "", right = " "} 
      section_separators = { left = '', right = ' '},
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {{'branch', padding = {left=2, right=2}}, 'diff', 'diagnostics'},
      lualine_c = {{'filename', file_status = true, path = 2}},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {{'location', padding = {right=1}}}
    },
    tabline = {
      lualine_a = { {'buffers', padding = {left=1, right=1}} }
    }
  }
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = config,
    lazy = false,

}
