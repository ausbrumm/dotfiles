vim.pack.add({ "https://github.com/elentok/open-link.nvim" }, { confirm = false })

local expanders = require("open-link.expanders")
require("open-link").setup({
  expanders = {
    expanders.github,
  },
})

vim.keymap.set("n", "ge", "<cmd>OpenLink<cr>", { desc = "Open the link under the cursor" })
vim.keymap.set("n", "<Leader>ip", "<cmd>PasteImage<cr>", { desc = "Paste image from clipboard" })
