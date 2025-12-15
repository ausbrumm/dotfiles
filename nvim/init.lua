require("config.lazy")
require("config.lspconfig")
require("config.lspconfig-cmds")
require("core")
require("plugins")

-- disable copilot by default
vim.cmd(":Copilot disable")
