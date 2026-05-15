vim.pack.add({ "https://github.com/folke/trouble.nvim" }, { confirm = false })

require("trouble").setup({})

vim.keymap.set("n", "<leader>t", function()
  require("trouble").toggle({ mode = "diagnostics" })
end, { desc = "Toggle trouble diagnostics" })

vim.keymap.set("n", "]t", function()
  require("trouble")._action("next")({ mode = "diagnostics", jump = true })
end, { desc = "Next trouble item" })

vim.keymap.set("n", "[t", function()
  require("trouble")._action("prev")({ mode = "diagnostics", jump = true })
end, { desc = "Prev trouble item" })
