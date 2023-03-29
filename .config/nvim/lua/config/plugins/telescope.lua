return {
	cmd = "Telescope",
	"nvim-telescope/telescope.nvim",
	version = "0.1",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		-- Telescope
		telescope.setup({
			defaults = {
				file_ignore_patterns = { "%.jpg", "%.png", "%.gif" },
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					prompt_prefix = "🔍 ",
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("persisted")
	end,
}
