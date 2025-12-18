-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local bufnr = event.buf
		local opts = { buffer = bufnr }

		-- Debug: print when LSP attaches

		-- Disable built-in omnifunc/completefunc to prevent double windows
		vim.bo[bufnr].omnifunc = ""
		vim.bo[bufnr].completefunc = ""

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

require("mason").setup({})

-- Requires nvim-cmp and cmp-nvim-lsp
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- Setup language servers (alphabetical order)

vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
})

-- Angular Language Server
vim.lsp.config("angularls", {
	cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		vim.fn.stdpath("data")
			.. "/mason/packages/angular-language-server/node_modules,"
			.. vim.fn.getcwd()
			.. "/node_modules",
		"--ngProbeLocations",
		vim.fn.stdpath("data")
			.. "/mason/packages/angular-language-server/node_modules/@angular/language-server/node_modules,"
			.. vim.fn.getcwd()
			.. "/node_modules/@angular/language-server/node_modules",
	},
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "angular.json", "project.json" })
		if root then
			on_dir(root)
		end
		-- returning nothing / not calling on_dir prevents server from starting
	end,
	capabilities = capabilities,
})

-- C/C++ Language Server
vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", "configure.ac", "Makefile" },
	capabilities = capabilities,
})

local mason = vim.fn.stdpath("data") .. "/mason/bin"

-- Go Language Server
vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work" },
	capabilities = capabilities,
})

-- HTML Language Server
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
	capabilities = capabilities,
})

-- Lua Language Server
vim.lsp.config("luals", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml" },
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

-- PHP Language Server
vim.lsp.config("phpactor", {
	cmd = { "phpactor", "language-server" },
	filetypes = { "php" },
	root_markers = { "composer.json", ".phpactor.json", ".phpactor.yml" },
	capabilities = capabilities,
})

-- Rust Language Server
vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = "clippy" },
		},
	},
})

-- Tailwind CSS Language Server
vim.lsp.config("tailwindcss", {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/tailwindcss-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"htmlangular",
		"angular",
	},
	root_markers = {
		"tailwind.config.js",
		"tailwind.config.ts",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"package.json",
	},
	capabilities = capabilities,
	settings = {
		tailwindCSS = {
			classAttributes = {
				"class",
				"className",
				"class:list",
				"classList",
				"ngClass",
			},
			experimental = {
				classRegex = {
					{ "tw`([^`]*)", 1 },
					{ 'tw="([^"]*)', 1 },
					{ 'tw={"([^"}]*)', 1 },
					{ "tw\\.\\w+`([^`]*)", 1 },
					{ 'class="([^"]*)', 1 },
					{ 'class: "([^"]*)', 1 },
					{ 'className="([^"]*)', 1 },
					{ 'ngClass: ?\\"([^"]*)', 1 },
					{ '\\[class\\]=\\"([^"]*)', 1 },
				},
			},
			includeLanguages = {
				htmlangular = "html",
				angular = "html",
			},
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			validate = true,
		},
	},
})

-- TypeScript Language Server
vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
	capabilities = capabilities,
	single_file_support = false,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false -- prevent lag from formatting
	end,
})

vim.lsp.config("cssls", {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/vscode-css-language-server", "--stdio" },
	filetypes = {
		"css",
		"scss",
		"less",
	},
	root_markers = {
		"package.json",
		".git",
		"style.css",
		"styles.css",
		"main.css",
		"index.css",
	},
	capabilities = capabilities,
	settings = {
		css = {
			validate = true,
			lint = {
				compatibleVendorPrefixes = "ignore",
				vendorPrefix = "warning",
				duplicateProperties = "warning",
				emptyRulesets = "warning",
				importStatement = "ignore",
				boxModel = "ignore",
				universalSelector = "ignore",
				zeroUnits = "ignore",
				fontFaceProperties = "warning",
				hexColorLength = "error",
				argumentsInColorFunction = "error",
				unknownProperties = "warning",
				ieHack = "ignore",
				unknownVendorSpecificProperties = "ignore",
				propertyIgnoredDueToDisplay = "warning",
				important = "ignore",
				float = "ignore",
				idSelector = "ignore",
			},
			completion = {
				triggerPropertyValueCompletion = true,
				completePropertyWithSemicolon = true,
			},
			hover = {
				documentation = true,
				references = true,
			},
			format = {
				enable = true,
				newlineBetweenSelectors = true,
				newlineBetweenRules = true,
				spaceAroundSelectorSeparator = true,
				braceStyle = "expand",
				maxPreserveNewLines = 2,
				preserveNewLines = true,
			},
			colorDecorators = {
				enable = true,
			},
			folding = {
				enable = true,
			},
		},
		scss = {
			validate = true,
			lint = {
				compatibleVendorPrefixes = "ignore",
				vendorPrefix = "warning",
				duplicateProperties = "warning",
				emptyRulesets = "warning",
				importStatement = "ignore",
				boxModel = "ignore",
				universalSelector = "ignore",
				zeroUnits = "ignore",
				fontFaceProperties = "warning",
				hexColorLength = "error",
				argumentsInColorFunction = "error",
				unknownProperties = "warning",
				ieHack = "ignore",
				unknownVendorSpecificProperties = "ignore",
				propertyIgnoredDueToDisplay = "warning",
				important = "ignore",
				float = "ignore",
				idSelector = "ignore",
			},
			completion = {
				triggerPropertyValueCompletion = true,
				completePropertyWithSemicolon = true,
			},
			hover = {
				documentation = true,
				references = true,
			},
			format = {
				enable = true,
				newlineBetweenSelectors = true,
				newlineBetweenRules = true,
				spaceAroundSelectorSeparator = true,
				braceStyle = "expand",
				maxPreserveNewLines = 2,
				preserveNewLines = true,
			},
			colorDecorators = {
				enable = true,
			},
			folding = {
				enable = true,
			},
		},
		less = {
			validate = true,
			lint = {
				compatibleVendorPrefixes = "ignore",
				vendorPrefix = "warning",
				duplicateProperties = "warning",
				emptyRulesets = "warning",
				importStatement = "ignore",
				boxModel = "ignore",
				universalSelector = "ignore",
				zeroUnits = "ignore",
				fontFaceProperties = "warning",
				hexColorLength = "error",
				argumentsInColorFunction = "error",
				unknownProperties = "warning",
				ieHack = "ignore",
				unknownVendorSpecificProperties = "ignore",
				propertyIgnoredDueToDisplay = "warning",
				important = "ignore",
				float = "ignore",
				idSelector = "ignore",
			},
			completion = {
				triggerPropertyValueCompletion = true,
				completePropertyWithSemicolon = true,
			},
			hover = {
				documentation = true,
				references = true,
			},
			format = {
				enable = true,
				newlineBetweenSelectors = true,
				newlineBetweenRules = true,
				spaceAroundSelectorSeparator = true,
				braceStyle = "expand",
				maxPreserveNewLines = 2,
				preserveNewLines = true,
			},
			colorDecorators = {
				enable = true,
			},
			folding = {
				enable = true,
			},
		},
	},
})

-- Enable only configured and installed LSP servers
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
