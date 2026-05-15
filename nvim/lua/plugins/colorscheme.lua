function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.pack.add({
  "https://github.com/rose-pine/neovim",
  "https://github.com/rijulpaul/nightblossom.nvim",
}, { confirm = false })

require("rose-pine").setup({
  disable_background = true,
  styles = {
    transparency = true,
  },
})

vim.cmd("colorscheme nightblossom")
