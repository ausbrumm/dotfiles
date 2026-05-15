vim.opt.termguicolors = true

vim.pack.add({ "https://github.com/NvChad/nvim-colorizer.lua" }, { confirm = false })

require("colorizer").setup({
  user_default_options = {
    mode = "background",
    names = false,
  },
})
