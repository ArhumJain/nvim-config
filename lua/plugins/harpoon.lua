return {
  'ThePrimeagen/harpoon',
  branch = "harpoon2",
  dependencies = {"nvim-lua/plenary.nvim"},
  lazy=false,
  config = function()
    local harpoon = require("harpoon")
    -- REQUIRED
    harpoon.setup({
      settings = {
        ui_nav_wrap = true,
      }
    })

  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
              results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
      }):find()
  end

  vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-q>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-w>", function() harpoon:list():select(2) end)
    -- vim.keymap.set("n", "<C-e>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-r>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-p>", function() harpoon:list():prev({ ui_nav_wrap = true }) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():next({ ui_nav_wrap = true }) end)

    require('telescope').load_extension('harpoon')
  end
}



