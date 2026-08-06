-- TypeScript Language Server
local common = require("config.lsp.common")

vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
	capabilities = common.capabilities,
	single_file_support = false,
	init_options = {
		preferences = {
			includeCompletionsForImportStatements = true,
			includeCompletionsWithSnippetText = true,
			importModuleSpecifierPreference = "non-relative",
			includeAutomaticOptionalChainCompletions = true,
		},
	},
})
