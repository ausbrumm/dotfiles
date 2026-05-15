vim.pack.add({ "https://github.com/mbbill/undotree" }, { confirm = false })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
