-- HTML Language Server
local common = require("config.lsp.common")

vim.lsp.config("html", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "package.json", "*.html" })
		-- Don't start for razor files
		local fname = vim.api.nvim_buf_get_name(bufnr)
		if root and not fname:match("%.razor$") then
			on_dir(root)
		end
	end,
	capabilities = common.capabilities,
})
