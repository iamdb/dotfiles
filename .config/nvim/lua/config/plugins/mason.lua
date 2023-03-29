return {
	cmd = {
		"Mason",
		"MasonInstall",
		"MasonUnInstall",
		"MasonLog",
	},
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = { "lua_ls", "svelte", "rust_analyzer", "tsserver" },
		})
	end,
}
