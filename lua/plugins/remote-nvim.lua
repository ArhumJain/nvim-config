local config = function()
  require("remote-nvim").setup({
    remote = {
      copy_dirs = {
        config = {
          compression = {
            enabled = true,
            additional_opts = { "--exclude-vcs" },
          }
        }
      }
    }
  })
end

return {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub releases
    dependencies = {
         "nvim-lua/plenary.nvim", -- For standard functions
         "MunifTanjim/nui.nvim", -- To build the plugin UI
         "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = config,
    lazy = false,
}
