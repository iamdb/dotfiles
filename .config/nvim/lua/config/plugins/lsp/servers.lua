local servers = {
	astro = {},
	clangd = {},
	eslint = {},
	dartls = {},
	gradle_ls = {
		settings = {
			gradleWrapperEnabled = true,
		},
	},
	graphql = {
		filetypes = { "graphql" },
	},
	kotlin_language_server = {},
	pyright = {},
	svelte = {},
	tailwindcss = {},
	terraformls = {
		filetypes = { "terraform", "tf" },
	},
	texlab = {},
	hls = {},
	lua_ls = {
		single_file_support = true,
		settings = {
			Lua = {
				runtime = "LuaJIT",
				workspace = {
					checkThirdParty = false,
				},
				completion = {
					workspaceWord = true,
					callSnippet = "Both",
				},
				misc = {
					parameters = {
						"--log-level=trace",
					},
				},
				diagnostics = {
					enable = true,
					disable = { "no-unknown" },
					groupSeverity = {
						strong = "Warning",
						strict = "Warning",
					},
					groupFileStatus = {
						["ambiguity"] = "Opened",
						["await"] = "Opened",
						["codestyle"] = "None",
						["duplicate"] = "Opened",
						["global"] = "Opened",
						["luadoc"] = "Opened",
						["redefined"] = "Opened",
						["strict"] = "Opened",
						["strong"] = "Opened",
						["type-check"] = "Opened",
						["unbalanced"] = "Opened",
						["unused"] = "Opened",
					},
					unusedLocalExclude = { "_*" },
				},
				format = {
					enable = false,
					defaultConfig = {
						indent_style = "space",
						indent_size = "2",
						continuation_indent_size = "2",
					},
				},
			},
		},
	},
	jsonls = {
		on_new_config = function(new_config)
			new_config.settings.json.schemas = new_config.settings.json.schemas or {}
			vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
		end,
		settings = {
			yaml = {
				format = {
					enable = true,
					bracketSpacing = false,
				},
				validate = { enable = true },
			},
		},
	},
	theme_check = {
		cmd = { "shopify", "theme", "language-server" },
	},
}

return servers
