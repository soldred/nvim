local function project_root()
	for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
		if client.config.root_dir and type(client.config.root_dir) == "string" then
			return client.config.root_dir
		end
	end

	local git = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if vim.v.shell_error == 0 and git and git ~= "" then
		return git
	end

	return vim.fn.getcwd()
end

local function copy_path(state)
	local node = state.tree:get_node()
	local path = node:get_id()
	local name = node.name
	local modify = vim.fn.fnamemodify

	local paths = {
		path,
		modify(path, ":."),
		modify(path, ":~"),
		name,
		modify(name, ":r"),
		modify(name, ":e"),
	}

	vim.ui.select({
		"Absolute: " .. paths[1],
		"Relative: " .. paths[2],
		"Home: " .. paths[3],
		"Filename: " .. paths[4],
		"Stem: " .. paths[5],
		"Extension: " .. paths[6],
	}, { prompt = "Copy path:" }, function(choice)
		if choice then
			local i = tonumber(choice:sub(1, 1))
			vim.fn.setreg("+", paths[i])
			vim.notify("Copied: " .. paths[i])
		end
	end)
end

require("neo-tree").setup({
	close_if_last_window = true,
    enable_diagnostics = true,
    
    sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols"
    },

    source_selector = {
		winbar = true,
		sources = {
			{ source = "filesystem", display_name = " 󰉓 File " },
			{ source = "git_status", display_name = " 󰊢 Git " },
			{ source = "buffers", display_name = " 󰓩 Buf " },
			{ source = "document_symbols", display_name = "  Sym " },
		},
	},

    bind_to_cwd = true,

	filesystem = {
		follow_current_file = {
			enabled = true,
		},
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
	},

	window = {
		width = 30,
		mappings = {
			["<space>"] = "none",
            ["P"] = {
				"toggle_preview",
				config = { use_float = true },
			},
            ["Y"] = copy_path,
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Open File explorer" })
