return {
	{
		"psliwka/vim-smoothie",
		event = "BufReadPre",
	},
	{
		"elkowar/yuck.vim",
		ft = { "yuck" },
	},
	{
		"ron-rs/ron.vim",
		ft = { "ron" },
	},
	{
		event = "BufReadPre",
		"kylechui/nvim-surround",
		config = true,
	},
	"nvim-lua/plenary.nvim",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				enable_afterquote = false,
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "BufReadPre",
		config = true,
	},
	{ "wakatime/vim-wakatime", config = function() end, event = "BufReadPre" },
	"ellisonleao/glow.nvim",
	{
		event = "BufReadPre",
		"kylechui/nvim-surround",
		version = "2",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		cmd = "Lspsaga",
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					enable = false,
				},
				diagnostic = {
					on_insert = true,
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		version = "2",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				icons = true,
				mode = "workspace_diagnostics",
				auto_preview = false,
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		version = "2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		end,
	},
}
