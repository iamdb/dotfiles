return {
	event = "BufReadPre",
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			ignore = "^$",
		})
	end,
}
