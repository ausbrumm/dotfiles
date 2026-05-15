-- C/C++ Language Server
local common = require("config.lsp.common")

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", "configure.ac", "Makefile" },
	capabilities = common.capabilities,
})
