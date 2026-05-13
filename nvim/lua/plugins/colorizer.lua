return {
  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      vim.opt.termguicolors = true
    end,
    opts = {
      user_default_options = {
        mode = "background",
        names = false,
      },
    },
  },
}
