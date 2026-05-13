-- Angular Language Server
local common = require("config.lsp.common")

vim.lsp.config("angularls", {
	cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		vim.fn.stdpath("data")
			.. "/mason/packages/angular-language-server/node_modules,"
			.. vim.fn.getcwd()
			.. "/node_modules",
		"--ngProbeLocations",
		vim.fn.stdpath("data")
			.. "/mason/packages/angular-language-server/node_modules/@angular/language-server/node_modules,"
			.. vim.fn.getcwd()
			.. "/node_modules/@angular/language-server/node_modules",
	},
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "angular.json", "project.json" })
		if root then
			on_dir(root)
		end
	end,
	capabilities = common.capabilities,
})
