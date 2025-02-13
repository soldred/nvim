return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	},
	keys = {
		{
			"<leader>]c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					require("gitsigns").nav_hunk("next")
				end
			end,
			desc = "Jump to next git change",
		},
		{
			"<leader>[c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					require("gitsigns").nav_hunk("prev")
				end
			end,
			desc = "Jump to previous git change",
		},
		{
			"<leader>hs",
			function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			mode = { "v" },
			desc = "git stage hunk",
		},
		{
			"<leader>hr",
			function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			mode = { "v" },
			desc = "git reset hunk",
		},
		{
			"<leader>hs",
			function()
				require("gitsigns").stage_hunk()
			end,
			desc = "git stage hunk",
		},
		{
			"<leader>hr",
			function()
				require("gitsigns").reset_hunk()
			end,
			desc = "git reset buffer",
		},
		{
			"<leader>hS",
			function()
				require("gitsigns").stage_buffer()
			end,
			desc = "git Stage buffer",
		},
		{
			"<leader>hu",
			function()
				require("gitsigns").undo_stage_hunk()
			end,
			desc = "git undo stage hunk",
		},
		{
			"<leader>hR",
			function()
				require("gitsigns").reset_buffer()
			end,
			desc = "git Reset buffer",
		},
		{
			"<leader>hp",
			function()
				require("gitsigns").preview_hunk()
			end,
			desc = "git preview hunk",
		},
		{
			"<leader>hb",
			function()
				require("gitsigns").blame_line()
			end,
			desc = "git blame line",
		},
		{
			"<leader>hd",
			function()
				require("gitsigns").diffthis()
			end,
			desc = "git diff against index",
		},
		{
			"<leader>hD",
			function()
				require("gitsigns").diffthis("@")
			end,
			desc = "git Diff against last commit",
		},
		{
			"<leader>tb",
			function()
				require("gitsigns").toggle_current_line_blame()
			end,
			desc = "Toggle git show blame line",
		},
		{
			"<leader>tD",
			function()
				require("gitsigns").preview_hunk_inline()
			end,
			desc = "Toggle git show Deleted",
		},
	},
}
