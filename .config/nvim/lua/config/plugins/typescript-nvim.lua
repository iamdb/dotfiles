local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")

	require("config.plugins.lsp.formatting").on_attach(client, bufnr)
	require("config.plugins.lsp.mappings").on_attach(client, bufnr)
end

return {
	"jose-elias-alvarez/typescript.nvim",
	ft = { "typescript", "typescriptreact", "svelte", "astro" },
	config = function()
		require("config.plugins.lsp.diagnostics").setup()

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		require("typescript").setup({ server = { on_attach, capabilities } })
	end,
}
