local marker = vim.fn.stdpath("state") .. "/lsp-log-cleanup"
local interval = 7 * 24 * 60 * 60

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local stat = vim.uv.fs_stat(marker)
		if stat and os.time() - stat.mtime.sec < interval then return end

		vim.fn.writefile({}, vim.lsp.log.get_filename())
		vim.fn.writefile({ tostring(os.time()) }, marker)
	end,
})
