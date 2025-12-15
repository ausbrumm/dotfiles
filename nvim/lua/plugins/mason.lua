return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"tailwindcss-language-server",
				"angular-language-server",
				"vue-language-server",
			},
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
}
