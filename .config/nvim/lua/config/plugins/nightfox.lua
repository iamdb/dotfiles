return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	cmd = "NightfoxCompile",
	version = "3",
	config = function()
		require("nightfox").setup({
			options = {
				styles = {
					comments = "italic",
					constants = "italic",
					types = "italic",
					functions = "italic",
				},
				inverse = {
					match_paren = false,
					visual = false,
					search = true,
				},
				modules = {
					cmp = true,
					neogit = true,
					fidget = true,
					gitsigns = true,
					lsp_trouble = true,
					lsp_saga = true,
					telescope = true,
					diagnostic = true,
					native_lsp = true,
					treesitter = true,
					leap = true,
				},
			},
		})

		vim.cmd([[colorscheme carbonfox]])
	end,
	build = function()
		require("nightfox").compile()
	end,
}
