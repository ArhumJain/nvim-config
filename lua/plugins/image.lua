local config = function()
  require("image").setup({})
end

return {
  "3rd/image.nvim",
  build = false,
  opts = {
    processor = "magick_cli"
  },
  config = config,
  lazy = false
}


