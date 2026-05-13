-- PHP Language Server
local common = require("config.lsp.common")

vim.lsp.config("phpactor", {
	cmd = { "phpactor", "language-server" },
	filetypes = { "php" },
	root_markers = { "composer.json", ".phpactor.json", ".phpactor.yml" },
	capabilities = common.capabilities,
})
