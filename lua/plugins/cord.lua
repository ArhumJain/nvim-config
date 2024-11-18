return {
  "vyfor/cord.nvim",
  build = './build || .\\build',
  event = 'VeryLazy',
  config = function ()
    require("cord").setup({
      idle = {
        show_status = false,
      }
    })
  end
}
