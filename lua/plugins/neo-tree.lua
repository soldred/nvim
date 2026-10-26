local function project_root()
	-- Root reported by an LSP client attached to the current buffer
	for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
		local root = client.config.root_dir
		if type(root) == "string" and root ~= "" then
			return root
		end
	end

	-- Git root, resolved from the current buffer's directory (not Neovim's cwd)
	local buf_dir = vim.fn.expand("%:p:h")
	if buf_dir == "" then
		buf_dir = vim.fn.getcwd()
	end
	local git = vim.fn.systemlist({ "git", "-C", buf_dir, "rev-parse", "--show-toplevel" })[1]
	if vim.v.shell_error == 0 and git and git ~= "" then
		return git
	end

	-- Fallback
	return vim.fn.getcwd()
end

local function copy_path(state)
	local node = state.tree:get_node()
	local path = node:get_id()
	local name = node.name
	local modify = vim.fn.fnamemodify

	local options = {
		{ label = "Absolute", value = path },
		{ label = "Relative", value = modify(path, ":.") },
		{ label = "Home", value = modify(path, ":~") },
		{ label = "Filename", value = name },
		{ label = "Stem", value = modify(name, ":r") },
		{ label = "Extension", value = modify(name, ":e") },
	}

	vim.ui.select(options, {
		prompt = "Copy path:",
		format_item = function(item)
			return item.label .. ": " .. item.value
		end,
	}, function(choice)
		if choice then
			vim.fn.setreg("+", choice.value)
			vim.notify("Copied: " .. choice.value)
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
		"document_symbols",
	},

	source_selector = {
		winbar = true,
		sources = {
			{ source = "filesystem", display_name = " 󰉓 File " },
			{ source = "git_status", display_name = " 󰊢 Git " },
			{ source = "buffers", display_name = " 󰓩 Buf " },
			{ source = "document_symbols", display_name = "  Sym " },
		},
	},

	filesystem = {
		-- We open at project_root() ourselves, so don't let Neo-tree
		-- re-bind the tree to the cwd on every directory change.
		bind_to_cwd = false,
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

vim.keymap.set("n", "<leader>e", function()
	require("neo-tree.command").execute({
		toggle = true,
		dir = project_root(),
	})
end, { desc = "Toggle file explorer (project root)" })
