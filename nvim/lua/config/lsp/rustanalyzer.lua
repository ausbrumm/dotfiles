-- Rust Language Server (rust-analyzer)
local common = require("config.lsp.common")

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	capabilities = common.capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				buildScripts = { enable = true },
			},
			checkOnSave = true,
			check = {
				command = "clippy",
				extraArgs = { "--no-deps" },
			},
			procMacro = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				experimental = { enable = true },
			},
			inlayHints = {
				bindingModeHints = { enable = true },
				chainingHints = { enable = true },
				closingBraceHints = { enable = true, minLines = 25 },
				closureReturnTypeHints = { enable = "with_block" },
				lifetimeElisionHints = { enable = "skip_trivial", useParameterNames = true },
				maxLength = 25,
				parameterHints = { enable = true },
				reborrowHints = { enable = "mutable" },
				renderColons = true,
				typeHints = {
					enable = true,
					hideClosureInitialization = false,
					hideNamedConstructor = false,
				},
			},
			lens = {
				enable = true,
				implementations = { enable = true },
				run = { enable = true },
				debug = { enable = true },
				references = {
					adt = { enable = true },
					enumVariant = { enable = true },
					method = { enable = true },
					trait = { enable = true },
				},
			},
		},
	},
})

-- Rust-specific LspAttach: code lens refresh + keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*.rs",
	desc = "Rust LSP extras",
	callback = function(event)
		local bufnr = event.buf
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client or client.name ~= "rust_analyzer" then return end

		-- Refresh code lens on enter and save
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			buffer = bufnr,
			callback = function()
				vim.lsp.codelens.refresh({ bufnr = bufnr })
			end,
		})

		local opts = { buffer = bufnr }
		-- Run nearest code lens action (run/test/debug)
		vim.keymap.set("n", "<leader>rl", vim.lsp.codelens.run, opts)
		-- Open external docs for symbol under cursor
		vim.keymap.set("n", "<leader>rd", function()
			vim.lsp.buf.execute_command({ command = "rust-analyzer.openDocs" })
		end, vim.tbl_extend("force", opts, { desc = "Open rust-analyzer docs" }))
		-- Toggle inlay hints for buffer
		vim.keymap.set("n", "<leader>rh", function()
			vim.lsp.inlay_hint.enable(
				not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
				{ bufnr = bufnr }
			)
		end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
	end,
})
