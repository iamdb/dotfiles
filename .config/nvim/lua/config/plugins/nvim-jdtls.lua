return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	config = function()
		local jdtls = require("jdtls")

		local client_capabilities = vim.lsp.protocol.make_client_capabilities()
		client_capabilities.workspace.configuration = true
		client_capabilities.textDocument.completion.completionItem.snippetSupport = true

		local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities)

		local home = os.getenv("HOME")
		local root_markers = { "gradlew" }
		local root_dir = require("jdtls.setup").find_root(root_markers)
		local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

		local config = {
			require("config.plugins.lsp.util").on_attach,
			capabilities,
			settings = {
				java = {
					saveActions = {
						organizeImports = true,
					},
					signatureHelp = { enabled = true },
					contentProvider = { preferred = "fernflower" },
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
					codeGeneration = {
						toString = {
							template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
						},
						hashCodeEquals = {
							useJava7Objects = true,
						},
						useBlocks = true,
					},
				},
			},
		}

		config.cmd = {
			"/usr/bin/java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx4g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			"-Dfile.encoding=UTF-8",
			"-jar",
			vim.fn.glob(
				home
					.. "/.local/share/eclipse/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar"
			),
			"-configuration",
			home .. "/.local/share/eclipse/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux",
			"-data",
			workspace_folder,
		}

		jdtls.start_or_attach(config)
		jdtls.setup.add_commands()
	end,
}
