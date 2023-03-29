return {
	cmd = "Neogit",
	"TimUntersberger/neogit",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neogit").setup({
			integrations = {
				diffview = true,
			},
		})
	end,
}
