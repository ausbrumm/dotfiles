vim.pack.add({ "https://github.com/folke/snacks.nvim" }, { confirm = false })

require("snacks").setup({
  bufdelete = { enabled = true },
  gitbrowse = { enabled = true },
  image = { enabled = true },
  picker = { enabled = true },
  rename = { enabled = true },
})

vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete buffer" })
vim.keymap.set({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git browse" })
vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename file" })
vim.keymap.set("n", "<leader>pf", function() Snacks.picker.files() end, { desc = "Find files" })
vim.keymap.set("n", "<C-p>", function() Snacks.picker.git_files() end, { desc = "Git files" })
vim.keymap.set("n", "<leader>pws", function() Snacks.picker.grep_word() end, { desc = "Grep word" })
vim.keymap.set("n", "<leader>pWs", function() Snacks.picker.grep({ search = vim.fn.expand("<cWORD>") }) end, { desc = "Grep string" })
vim.keymap.set("n", "<leader>ps", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>vh", function() Snacks.picker.help() end, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Files" })
vim.keymap.set("n", "<leader>f", function() Snacks.picker() end, { desc = "Pick" })
