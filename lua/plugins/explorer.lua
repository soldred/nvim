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
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				local dir = ""

				if #clients > 0 and clients[1].config.root_dir then
					dir = clients[1].config.root_dir
				else
					dir = vim.fn.getcwd()
				end

				vim.cmd("Neotree toggle dir=" .. vim.fn.fnameescape(dir))
			end,
			desc = "Toggle explorer",
			silent = true,
		},
	},
	opts = {
		event_handlers = {
			{ event = "file_moved", handler = function(data) Snacks.rename.on_rename_file(data.source, data.destination) end },
			{ event = "file_renamed", handler = function(data) Snacks.rename.on_rename_file(data.source, data.destination) end },
		},
		popup_border_style = "rounded",
		enable_diagnostics = true,
		open_files_do_no_replace_typec = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
			use_libuv_file_watcher = false,
		},
		bind_to_cwd = true,
		source_selector = {
			winbar = true,
			sources = {
				{ source = "filesystem", display_name = " 󰉓 File " },
				{ source = "git_status", display_name = " 󰊢 Git " },
				{ source = "buffers", display_name = " 󰓩 Buf " },
				{ source = "document_symbols", display_name = "  Sym " },
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
			},
			symbols = {
				-- Change type
				added = "+", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "~", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
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

