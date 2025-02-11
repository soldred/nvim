return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", build = ":MasonToolsUpdate" },
	},
	build = ":MasonUpdate",
	config = function()
		require("mason").setup({
			PATH = "prepend",
			automatic_installation = true,
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			lua_ls = {
				settings = {
					completions = {
						callSnippet = "Replace",
					},
				},
			},
			clangd = {},
			intelephense = {},
			pyright = {},
			ts_ls = {},
			html = {},
			cssls = {},
			css_variables = {},
			cssmodules_ls = {},
			jsonls = {},
		}

		local ensure_installed = vim.tbl_keys(servers or {})

		---@diagnostic disable-next-line: missing-fields
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
		vim.list_extend(ensure_installed, {
			"stylua", -- formatter for Lua
			"luacheck", -- linter for Lua
			"php-cs-fixer", -- formatter for php
			"clang-format", -- formatter for c++
			"prettierd", -- formatter for js, js, html, css, scss and more
			"ruff", -- formatter and linter for python
		})

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			automatic_installation = true,
		})
	end,
}
