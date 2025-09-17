function ColorMyPencils(color)
  color = color or "nightblossom"
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        styles = {
          transparency = true,
        },
      })

      vim.cmd("colorscheme rose-pine")
      ColorMyPencils()
    end
  },
  {
    "rijulpaul/nightblossom.nvim",
    name = "nightblossom",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nightblossom")
    end,
  }
}
