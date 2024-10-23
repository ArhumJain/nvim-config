local config = function() 
  require('telescope').setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous
        },
      },
    },
})
end
return {
  'nvim-telescope/telescope.nvim', config = config, lazy=false, tag="0.1.8", dependencies = { "nvim-lua/plenary.nvim" }
}
