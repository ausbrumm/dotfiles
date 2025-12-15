require("core.options")
require("core.mappings")

local augroup = vim.api.nvim_create_augroup
local ausbrumm_group = augroup("ausbrumm", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

vim.opt.completeopt = { "menu", "menuone", "noselect" } -- safe for cmp
vim.o.shortmess = vim.o.shortmess .. "c" -- avoid extra messages during completion
vim.opt.complete = ""

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
	end,
})

autocmd({ "BufWritePre" }, {
	group = ausbrumm_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = ausbrumm_group,
	callback = function(args)
		vim.bo[args.buf].omnifunc = ""
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.o.completeopt = "menu,menuone,noselect"
vim.opt.shortmess:append("c") -- Optional: removes "match 1 of 2" messages

-- If you don't use native completion:
vim.api.nvim_set_option("omnifunc", "") -- Only if needed

vim.api.nvim_set_option("completefunc", "") -- Only if needed

-- custom file types
vim.filetype.add({
	pattern = {
		[".*%.component%.html"] = "htmlangular",
	},
})
vim.filetype.add({
	extension = {
		razor = "razor",
	},
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*__virtual.*",
	callback = function(args)
		vim.bo[args.buf].buftype = "nofile"
		vim.bo[args.buf].bufhidden = "hide"
		vim.bo[args.buf].swapfile = false
	end,
})
