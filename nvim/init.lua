vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("plugins")
require("config.lspconfig")
require("config.lspconfig-cmds")
require("core")

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.fn.exists(":Copilot") == 2 then
      vim.cmd("Copilot disable")
    end
  end,
})
