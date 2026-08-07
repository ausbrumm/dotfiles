-- NestJS: extra ts_ls workspace settings applied when nest-cli.json is detected.
-- Not a standalone server — piggybacks on the ts_ls instance started by tsls.lua.

vim.api.nvim_create_autocmd("LspAttach", {
	pattern = { "*.ts" },
	desc = "NestJS ts_ls extras",
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client or client.name ~= "ts_ls" then return end

		local root = client.config.root_dir
		if not root or vim.fn.filereadable(root .. "/nest-cli.json") == 0 then return end

		-- Push NestJS-specific workspace configuration to the running ts_ls instance
		client:notify("workspace/didChangeConfiguration", {
			settings = {
				typescript = {
					preferences = {
						importModuleSpecifier = "non-relative",
						includePackageJsonAutoImports = "auto",
					},
					suggest = {
						completeFunctionCalls = true,
						includeCompletionsForImportStatements = true,
						includeAutomaticOptionalChainCompletions = true,
					},
					inlayHints = {
						parameterNames = { enabled = "all" },
						parameterTypes = { enabled = true },
						variableTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
					-- Suppress decorator-related false positives when using ts_ls without tsc
					diagnostics = {
						ignoredCodes = { 7016, 2307 },
					},
				},
			},
		})

		-- NestJS-specific keymaps (only active in NestJS projects)
		local bufnr = event.buf
		local opts = { buffer = bufnr }

		-- Find all files matching a NestJS class type across the project
		vim.keymap.set("n", "<leader>nm", function()
			Snacks.picker.files({ title = "Modules", pattern = ".module.ts" })
		end, vim.tbl_extend("force", opts, { desc = "NestJS: find modules" }))

		vim.keymap.set("n", "<leader>nc", function()
			Snacks.picker.files({ title = "Controllers", pattern = ".controller.ts" })
		end, vim.tbl_extend("force", opts, { desc = "NestJS: find controllers" }))

		vim.keymap.set("n", "<leader>ns", function()
			Snacks.picker.files({ title = "Services", pattern = ".service.ts" })
		end, vim.tbl_extend("force", opts, { desc = "NestJS: find services" }))

		vim.keymap.set("n", "<leader>nd", function()
			Snacks.picker.files({ title = "DTOs", pattern = ".dto.ts" })
		end, vim.tbl_extend("force", opts, { desc = "NestJS: find DTOs" }))

		vim.keymap.set("n", "<leader>ng", function()
			Snacks.picker.files({ title = "Guards", pattern = ".guard.ts" })
		end, vim.tbl_extend("force", opts, { desc = "NestJS: find guards" }))
	end,
})
