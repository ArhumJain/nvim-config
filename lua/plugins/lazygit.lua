local config = function() 
end

return {
  "kdheepak/lazygit.nvim",
  lazy = true,

  config = config,

  keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  }
}
