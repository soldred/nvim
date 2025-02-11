return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	keys = {
		{ "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Search Help" },
		{ "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Search Keymaps" },
		{ "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "Seach Files" },
		{ "<leader>ss", "<cmd>Telescope builtin<CR>", desc = "Search Select Telescope" },
		{ "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "Seach current Word" },
		{ "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Search by Grep" },
		{ "<leader>sd", "<cmd>Telescop diagnostics<CR>", desc = "Search Diagnostics" },
		{ "<leader>s.", "<cmd>Telescope oldfiles<CR>", desc = "Search Recent Fiels ('.' ro repeat)" },
		{ "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "Find existing buffers" },
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					windblend = 10,
					previewer = false,
				}))
			end,
			desc = "Fuzzily search in current buffer",
		},
		{
			-- Shortcut for searching your Neovim config file
			"<leader>sn",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "Search Neovim Files",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						-- ["<C-q>"] = actions.send_selected_to_qfilist,
						-- ["<C-o>"] = actions.open_qflist,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				file_ignore_patterns = { "node_modules", ".git", ".venv" },
				hidden = true,
			},
			live_grep = {
				file_ignore_patterns = { "node_modules", ".git", ".venv" },
				additions_args = function(_)
					return { "--hidden" }
				end,
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
	end,
}
