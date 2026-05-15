-- HTML Language Server
local common = require("config.lsp.common")

vim.lsp.config("html", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package.json", ".git" },
	capabilities = common.capabilities,
})

-- Exclude razor files — html-ls and roslyn both attach to .razor; let roslyn own it
vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*.razor",
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.name == "html" then
			vim.lsp.buf_detach_client(event.buf, client.id)
		end
	end,
})
