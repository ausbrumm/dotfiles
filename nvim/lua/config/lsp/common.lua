-- Shared LSP configuration: capabilities, LspAttach autocmd
local M = {}

-- Setup Mason
require("mason").setup({})

-- Setup capabilities with nvim-cmp
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M.capabilities = capabilities

-- Diagnostic display (0.12: virtual_lines stable, only_current_line supported)
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { only_current_line = true },
	signs = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- LspAttach autocmd for keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local bufnr = event.buf
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local opts = { buffer = bufnr }

		-- Disable built-in omnifunc/completefunc to prevent double windows
		vim.bo[bufnr].omnifunc = ""
		vim.bo[bufnr].completefunc = ""

		-- ts_ls manages its own formatting via conform/prettierd
		if client and client.name == "ts_ls" then
			client.server_capabilities.documentFormattingProvider = false
		end

		-- Enable inlay hints if the server supports them
		if client and client.supports_method("textDocument/inlayHint", bufnr) then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		-- Keymaps
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "gc", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
	end,
})

-- Global config for all LSP servers
vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
	handlers = {
		["textDocument/hover"] = function(_, result, ctx, config)
			return vim.lsp.handlers.hover(_, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
		end,
		["textDocument/signatureHelp"] = function(_, result, ctx, config)
			return vim.lsp.handlers.signature_help(_, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
		end,
	},
})

return M
