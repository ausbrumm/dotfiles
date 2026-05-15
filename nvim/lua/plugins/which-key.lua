vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })

vim.o.timeout = true
vim.o.timeoutlen = 200

require("which-key").setup({})
