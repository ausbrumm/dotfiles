-- Angular Language Server
local common = require("config.lsp.common")

local mason_pkg = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules"

vim.lsp.config("angularls", {
	-- cmd is a function so node_modules paths are resolved against the actual project root
	cmd = function(config)
		local root = config.root_dir or vim.fn.getcwd()
		return {
			"ngserver",
			"--stdio",
			"--tsProbeLocations",
			mason_pkg .. "," .. root .. "/node_modules",
			"--ngProbeLocations",
			mason_pkg .. "/@angular/language-server/node_modules,"
				.. root .. "/node_modules/@angular/language-server/node_modules",
		}
	end,
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "angular.json", "project.json" })
		if root then
			on_dir(root)
		end
	end,
	capabilities = common.capabilities,
})
