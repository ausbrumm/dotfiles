-- Tailwind CSS Language Server
local common = require("config.lsp.common")

vim.lsp.config("tailwindcss", {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
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
	capabilities = common.capabilities,
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
