return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		event = "LspAttach",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			codelens = {
				enabled = false,
			},
			-- capabilities = {
			-- 	wokspace = {
			-- 		fileOperations = {
			-- 			didRename = true,
			-- 			willRename = true,
			-- 		}
			-- 	}
			-- }
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP Actions",
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
					end

					map("gd", function()
						Snacks.picker.lsp_definitions()
					end, "Goto Definition")
					map("gD", function()
						Snacks.picker.lsp_declarations()
					end, "Goto Declaration")
					map("gr", function()
						Snacks.picker.lsp_references()
					end, "Goto Reference")
					map("gI", function()
						Snacks.picker.lsp_implementations()
					end, "Goto Implementation")
					map("<leader>cR", function()
						Snacks.rename.rename_file()
					end, "Rename File")
					map("<leader>ss", function()
						Snacks.picker.lsp_symbols()
					end, "Lsp Symbols")
					map("<leader>sS", function()
						Snacks.picker.lsp_workspace_symbols()
					end, "LSP Worksapce Symbols")
					map("<leader>cr", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			-- This neede for checking if certain plugins installed
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local has_blink, blink = pcall(require, "blink.cmp")

			-- Setup capabilities
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				has_blink and blink.get_lsp_capabilities() or {},
				opts.capabilities or {}
			)
			local lspconfig = require("lspconfig")

			-- Set global defaults for all servers
			lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
				capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					-- returns configured operations if setup() was already called
					-- or default operations if not
					require("lsp-file-operations").default_capabilities()
				),
			})
			-- Here you can setup servers separately
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completions = {
								callSnippet = "Reaplace",
							},
							diagnostics = {
								disable = {
									"missing-fields",
								},
							},
						},
					},
				},
				clangd = {},
				pyright = {},
				intelephense = {},
				phpactor = {},
				html = {},
				emmet_ls = {},
				cssls = {},
				css_variables = {},
				cssmodules_ls = {},
				jsonls = {},
				ts_ls = {},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- lua formatter
				"prettierd", -- js formatter
				"php-cs-fixer", -- php formatter
				"clang-format", -- c, c++ formatter
				"ruff", -- python formatter
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			-- Setup servers
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
