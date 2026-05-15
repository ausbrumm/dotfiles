-- Go Language Server
local common = require("config.lsp.common")

vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work" },
	capabilities = common.capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
				unusedwrite = true,
			},
			staticcheck = true,
			gofumpt = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralTypes = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})
