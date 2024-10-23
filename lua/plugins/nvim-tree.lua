local config = function() 
  require("nvim-tree").setup({

  })
end
return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  config = config
}
