local config = function() 
  require("nvim-tree").setup({
    sync_root_with_cwd = true,
    filters = {
      git_ignored = false, -- show git-ignored files
    },
    renderer = {
      highlight_git = "name", -- mark files by git status (ignored files get dimmed + ◌ icon)
    },
  })
end
return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  config = config
}
