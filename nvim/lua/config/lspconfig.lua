-- LSP Configuration Entry Point
-- Load shared config (capabilities, keymaps, etc.)
require("config.lsp.common")

-- Load individual server configurations
require("config.lsp.angularls")
require("config.lsp.clangd")
require("config.lsp.cssls")
require("config.lsp.gopls")
require("config.lsp.html")
require("config.lsp.luals")
require("config.lsp.phpactor")
require("config.lsp.rustanalyzer")
require("config.lsp.tailwindcss")
require("config.lsp.tsls")

-- Enable servers that use vim.lsp.config
-- NOTE: eslint is NOT included here because it uses nvim-lspconfig
vim.lsp.enable({
	"angularls",
	"clangd",
	"cssls",
	"gopls",
	"html",
	"luals",
	"phpactor",
	"rust_analyzer",
	"tailwindcss",
	"ts_ls",
})
