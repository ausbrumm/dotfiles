vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

vim.pack.add({ "https://github.com/folke/edgy.nvim" }, { confirm = false })

require("edgy").setup({
	left = {
		{
			title = "Files",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "filesystem"
			end,
			pinned = true,
			open = "Neotree position=left filesystem reveal",
			size = { width = 0.25, height = 0.5 },
			wo = {
				winbar = true,
				number = false,
				relativenumber = false,
				signcolumn = "no",
				foldcolumn = "0",
				wrap = false,
				winhighlight = "Normal:EdgyNormal,WinBar:EdgyWinBar,WinBarNC:EdgyWinBarNC",
			},
		},
		{
			title = "Trouble",
			ft = "trouble",
			filter = function(_, win)
				return vim.w[win].trouble ~= nil
			end,
			size = { width = 0.25, height = 0.4 },
			wo = {
				winbar = true,
				number = false,
				relativenumber = false,
				signcolumn = "no",
				foldcolumn = "0",
				wrap = false,
				winhighlight = "Normal:EdgyNormal,WinBar:EdgyWinBar,WinBarNC:EdgyWinBarNC",
			},
		},
	},

	right = {},
	bottom = {},
	top = {},

	options = {
		left = { size = 36 },
	},

	animate = {
		enabled = false,
	},

	icons = {
		closed = "",
		open = "",
	},

	exit_when_last = false,
	close_when_all_hidden = true,


	keys = {
		["q"] = function(win)
			win:hide()
		end,
		["Q"] = function(win)
			win.view.edgebar:close()
		end,
	},
})

local function edgy_resize(dir, amount)
	local win = require("edgy").get_win()
	if win then
		win:resize(dir, amount)
	end
end

vim.keymap.set("n", "<leader>wl", function() edgy_resize("width", 2) end,   { desc = "Edgy grow width" })
vim.keymap.set("n", "<leader>wh", function() edgy_resize("width", -2) end,  { desc = "Edgy shrink width" })
vim.keymap.set("n", "<leader>wk", function() edgy_resize("height", 2) end,  { desc = "Edgy grow height" })
vim.keymap.set("n", "<leader>wj", function() edgy_resize("height", -2) end, { desc = "Edgy shrink height" })

vim.keymap.set("n", "<leader>e", function()
	require("edgy").toggle("left")
end, { desc = "Toggle left panel" })
