-- CSS Language Server
local common = require("config.lsp.common")

local lint = {
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
}

local format = {
	enable = true,
	newlineBetweenSelectors = true,
	newlineBetweenRules = true,
	spaceAroundSelectorSeparator = true,
	braceStyle = "expand",
	maxPreserveNewLines = 2,
	preserveNewLines = true,
}

local hover = { documentation = true, references = true }
local completion = { triggerPropertyValueCompletion = true, completePropertyWithSemicolon = true }
local shared = { validate = true, lint = lint, completion = completion, hover = hover, format = format }

vim.lsp.config("cssls", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git", "style.css", "styles.css", "main.css", "index.css" },
	capabilities = common.capabilities,
	settings = {
		css = shared,
		scss = shared,
		less = shared,
	},
})
