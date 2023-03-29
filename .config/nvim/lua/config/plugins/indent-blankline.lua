return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("indent_blankline").setup({
			char = "▏",
			space_char_blankline = " ",
			buftype_exclude = { "terminal", "help", "dashboard", "nofile" },
			show_current_context = true,
			show_current_context_start = false,
			show_trailing_blankline_indent = true,
			use_treesitter = true,
		})
	end,
}
