vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, { confirm = false })

require("render-markdown").setup({
  latex = { enabled = false },
  yaml = { enabled = false },
})
