return {
	"simrat39/rust-tools.nvim",
	ft = { "rust" },
	config = function()
		local on_attach = require("config.plugins.lsp.util").on_attach
		local capabilities = require("config.plugins.lsp.util").capabilities

		require("rust-tools").setup({
			on_attach,
			capabilities,
			server = {
				settings = {
					["rust-analyzer"] = {
						assist = {
							importGranularity = "crate",
							importPrefix = "crate",
						},
						procMacro = {
							enable = true,
						},
						checkOnSave = {
							enable = true,
							overrideCommand = {
								"cargo",
								"clippy",
								"--workspace",
								"--message-format=json",
								"--all-targets",
								"--all-features",
							},
						},
					},
				},
			},
			tools = {
				runnables = {
					use_telescope = true,
				},
				inlay_hints = {
					auto = true,
					show_parameter_hints = true,
					max_len_align = true,
				},
			},
		})
	end,
}
