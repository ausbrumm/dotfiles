-- TypeScript Language Server
local common = require("config.lsp.common")

vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
	capabilities = common.capabilities,
	single_file_support = false,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
})
