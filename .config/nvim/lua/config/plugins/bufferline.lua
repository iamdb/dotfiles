return {
	event = "BufReadPre",
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("bufferline").setup({
			options = {
				always_show_bufferline = false,
				mode = "tabs",
				diagnostics = "nvim_lsp",
				separator_style = "thick",
			},
		})
	end,
}
