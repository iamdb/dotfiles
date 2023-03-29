return {
	cmd = "ToggleTerm",
	"akinsho/toggleterm.nvim",
	config = function()
		local Terminal = require("toggleterm.terminal").Terminal

		-- SETUP

		require("toggleterm").setup({
			shade_terminals = false,
			shading_factor = 3,
			start_in_insert = false,
		})

		-- Terminals

		local tail_output = Terminal:new({
			cmd = [[
            if [ -f out ]; then
                tail -f out
            else 
                echo "missing out file"
                sleep 2
                exit
            fi
        ]],
			auto_scroll = true,
			hidden = true,
		})

		function _Tail_output_toggle()
			tail_output:toggle()
		end

		vim.api.nvim_set_keymap("n", "<C-,>", "<cmd>lua _Tail_output_toggle()<CR>", { noremap = true, silent = true })

		-- Terminal Keymaps

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
