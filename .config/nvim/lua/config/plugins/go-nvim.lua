return {
	"ray-x/go.nvim",
	ft = { "go", "gomod" },
	event = { "CmdlineEnter" },
	build = ':lua require("go.install").update_all_sync()',
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local on_attach = require("config.plugins.lsp.util").on_attach

		require("go").setup({
			lsp_on_attach = on_attach,
			lsp_cfg = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					gopls = {
						matcher = "CaseInsensitive",
						gofumpt = true,
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			},
		})
	end,
}
