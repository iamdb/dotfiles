local M = {}

function M.format(buf)
	vim.lsp.buf.format({
		bufnr = buf,
		filter = function(client)
			return client.name == "null-ls" or client.name == "gopls" or client.name == "hls"
		end,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function M.on_attach(client, buf)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = buf })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = buf,
			callback = function()
				M.format(buf)
			end,
		})
	end
end

return M
