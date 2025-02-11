return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>e",
			function()
				vim.cmd("Neotree toggle")
			end,
			desc = "Toggle explorer",
			silent = true,
		},
	},
	opts = {
		popup_border_style = "rounded",
		enable_diagnostics = true,
		open_files_do_no_replace_typec = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		sources = { "filesystem", "buffers", "git_status" },
		source_selector = {
			winbar = true,
			sources = {
				{ source = "filesystem", display_name = " 󰉓 File " },
				{ source = "git_status", display_name = " 󰊢 Git " },
				{ source = "buffers", display_name = " 󰓩 Buf " },
				-- { source = "document_symbols", display_name = "  Sym " },
			},
			-- content_layout = "center",
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			git_status = {
				enable = true,
				symbols = {
					unstaged = "󰄱",
					staged = "󰱒",
				},
			},
		},

		window = {
			position = "left",
			width = 35,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["P"] = { "toggle_preview", config = { use_float = true } },
				["Y"] = function(state)
					-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
					-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local results = {
						filepath,
						modify(filepath, ":."),
						modify(filepath, ":~"),
						filename,
						modify(filename, ":r"),
						modify(filename, ":e"),
					}

					vim.ui.select({
						"1. Absolute path: " .. results[1],
						"2. Path relative to CWD: " .. results[2],
						"3. Path relative to HOME: " .. results[3],
						"4. Filename: " .. results[4],
						"5. Filename without extension: " .. results[5],
						"6. Extension of the filename: " .. results[6],
					}, { prompt = "Choose to copy to clipboard:" }, function(choice)
						if choice then
							local i = tonumber(choice:sub(1, 1))
							if i then
								local result = results[i]
								vim.fn.setreg("+", result)
								vim.notify("Copied: " .. result)
							else
								vim.notify("Invalid selection")
							end
						else
							vim.notify("Selection cancelled")
						end
					end)
				end,
			},
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
	end,
}
