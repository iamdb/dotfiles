return {
	"nvim-neorg/neorg",
	cmd = "Neorg",
	ft = "norg",
	build = ":Neorg sync-parsers",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.norg.dirman"] = {
					config = {
						workspaces = {
							default = "~/Code/org",
						},
						autochdir = true,
					},
				},
				["core.norg.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.norg.concealer"] = {
					config = {
						icon_preset = "basic",
						conceal = true,
						folds = true,
					},
				},
			},
		})
	end,
}
