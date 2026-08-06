vim.pack.add({
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/nvim-lua/plenary.nvim",
}, { confirm = false })

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add current file to harpoon" })
vim.keymap.set("n", "<C-d>", function() harpoon:list():remove() end, { desc = "Remove current file from harpoon" })
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

local function toggle_harpoon(harpoon_files)
  local items = {}
  for index, item in ipairs(harpoon_files.items) do
    items[#items + 1] = { file = item.value, index = index }
  end

  Snacks.picker({
    title = "Harpoon",
    items = items,
    format = "file",
    confirm = function(picker, item)
      picker:close()
      harpoon_files:select(item.index)
    end,
  })
end

vim.keymap.set("n", "<C-e>", function() toggle_harpoon(harpoon:list()) end, { desc = "Open harpoon window" })
