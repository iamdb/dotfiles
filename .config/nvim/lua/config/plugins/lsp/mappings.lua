local M = {}

function M.on_attach(_, buffer)
	local opts = { noremap = true, silent = true }

	local map = function(type, key, value)
		vim.api.nvim_buf_set_keymap(buffer, type, key, value, opts)
	end

	vim.api.nvim_buf_set_keymap(buffer, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buffer, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

	-- Keybindings
	map("n", "gt", "<cmd>Telescope treesitter<cr>")
	map("n", "<leader>xx", "<cmd>Trouble<cr>")
	map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
	map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
	map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
	map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
	map("n", "gR", "<cmd>Trouble lsp_references<cr>")

	-- Lsp finder find the symbol definition implement reference
	-- if there is no implement it will hide
	-- when you use action in finder like open vsplit then you can
	-- use <C-t> to jump back
	map("n", "gh", [[<cmd>Lspsaga lsp_finder<CR>]])

	-- Code action
	map("n", "<leader>ca", [[<cmd>Lspsaga code_action<CR>]])

	-- Rename
	map("n", "gr", [[<cmd>Lspsaga rename<CR>]])

	-- Peek Definition
	-- you can edit the definition file in this flaotwindow
	-- also support open/vsplit/etc operation check definition_action_keys
	-- support tagstack C-t jump back
	map("n", "gd", [[<cmd>Lspsaga peek_definition<CR>]])

	-- Show line diagnostics
	map("n", "<leader>cd", [[<cmd>Lspsaga show_line_diagnostics<CR>]])

	-- Show cursor diagnostic
	map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

	-- Diagnsotic jump can use `<c-o>` to jump back
	map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

	-- Only jump to error
	map(
		"n",
		"[E",
		[[<cmd>lua require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>]]
	)
	map(
		"n",
		"]E",
		[[<cmd>lua require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>]]
	)

	-- Outline
	map("n", "<leader>o", [[<cmd>LSoutlineToggle<CR>]])

	-- Hover Doc
	map("n", "K", [[<cmd>Lspsaga hover_doc ++quiet<CR>]])

	-- Float terminal
	map("n", "<A-d>", [[<cmd>Lspsaga open_floaterm<CR>]])
	-- if you want pass somc cli command into terminal you can do like this
	-- open lazygit in lspsaga float terminal
	map("n", "<A-d>", [[<cmd>Lspsaga open_floaterm lazygit<CR>]])
	-- close floaterm
	map("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
end

return M
