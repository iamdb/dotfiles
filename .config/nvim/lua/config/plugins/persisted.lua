return {
	event = "VimEnter",
	"olimorris/persisted.nvim",
	opts = {
		autoload = true,
		autosave = true,
		allowed_dirs = {
			"~/Code",
			"~/.config/nvim",
			"~/.config/xmonad",
		},
	},
}
