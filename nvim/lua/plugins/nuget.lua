vim.pack.add({
  "https://github.com/MonsieurTib/neonuget",
  "https://github.com/nvim-lua/plenary.nvim",
}, { confirm = false })

require("neonuget").setup({
  dotnet_path = "dotnet",
  default_project = nil,
})
