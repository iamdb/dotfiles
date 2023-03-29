local servers = require("config.plugins.lsp.servers")

return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			local on_attach = require("config.plugins.lsp.util").on_attach
			local capabilities = require("config.plugins.lsp.util").capabilities

			require("config.plugins.lsp.diagnostics").setup()

			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				opts.on_attach = on_attach

				require("lspconfig")[server].setup(opts)
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		config = function()
			local nls = require("null-ls")

			local on_attach = require("config.plugins.lsp.util").on_attach

			nls.setup({
				on_attach = on_attach,
				save_after_format = false,
				sources = {
					-- PYTHON
					nls.builtins.formatting.black,
					-- SHELL
					nls.builtins.diagnostics.shellcheck,
					-- LUA
					nls.builtins.formatting.stylua,
					-- GO
					nls.builtins.formatting.gofumpt,
					nls.builtins.formatting.goimports,
					-- TAILWIND
					nls.builtins.formatting.rustywind,
					-- TYPESCRIPT
					nls.builtins.formatting.prettierd.with({
						extra_filetypes = { "svelte" },
					}),
					-- RUST
					nls.builtins.formatting.rustfmt,
					-- JAVA
					nls.builtins.diagnostics.checkstyle.with({
						-- command = {
						-- 	"java",
						-- 	"-jar",
						-- 	"/usr/share/java/checkstyle/checkstyle.jar",
						-- 	"$@",
						-- },
						extra_args = {
							"-c",
							"/usr/local/lift/checkstyle-algs4.xml",
						},
					}),
				},
			})
		end,
	},
}
