local function session()
	if vim.g.persisting == true then
		return [[]]
	else
		return [[]]
	end
end

return {
	lazy = false,
	"nvim-lualine/lualine.nvim",
	config = function()
		local lualine = require("lualine")

		local filetype = {
			"filetype",
			colored = true,
		}

		local filename = {
			"filename",
			file_status = false,
			separator = { left = "", right = "" },
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic", "nvim_lsp", "nvim_workspace_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			update_in_insert = true,
		}

		local encoding = {
			"o:encoding",
			separator = { left = "", right = "" },
		}

		local location = { "location", separator = { left = "", right = "" } }

		lualine.setup({
			options = {
				icons_enabled = true,
				globalstatus = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { filename, diagnostics },
				lualine_x = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
					session,
					encoding,
					filetype,
				},
				lualine_y = { "progress" },
				lualine_z = { location },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { filename },
				lualine_x = { location },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
		})
	end,
}
