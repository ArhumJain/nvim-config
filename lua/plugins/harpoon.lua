return {
  'ThePrimeagen/harpoon',
  branch = "harpoon2",
  dependencies = {"nvim-lua/plenary.nvim"},
  lazy=false,
  config = function()
    local harpoon = require("harpoon")
    -- REQUIRED
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-q>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-w>", function() harpoon:list():select(2) end)
    -- vim.keymap.set("n", "<C-e>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-r>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
  end
}



