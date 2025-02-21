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
			"]c",
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
			"[c",
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
			"<leader>ghs",
			function()
				require("gitsigns").stage_hunk()
			end,
			desc = "Stage Hunk",
		},
		{
			"<leader>ghr",
			function()
				require("gitsigns").reset_hunk()
			end,
			desc = "Reset Hunk",
		},
		{
			"<leader>ghS",
			function()
				require("gitsigns").stage_buffer()
			end,
			desc = "Stage Buffer",
		},
		{
			"<leader>ghR",
			function()
				require("gitsigns").reset_buffer()
			end,
			desc = "Reset Buffer",
		},
		{
			"<leader>ghp",
			function()
				require("gitsigns").preview_hunk()
			end,
			desc = "Preview Hunk",
		},

		{
			"<leader>ghb",
			function()
				require("gitsigns").blame_line()
			end,
			desc = "Blame Line",
		},
		{
			"<leader>ghB",
			function()
				require("gitsigns").blame()
			end,
			desc = "Blame Buffer",
		},
		{
			"<leader>ghd",
			function()
				require("gitsigns").diffthis()
			end,
			desc = "Diff Against Index",
		},
		{
			"<leader>ghD",
			function()
				require("gitsigns").diffthis("@")
			end,
			desc = "Diff Against Last Commit",
		},
		{
			"<leader>gtb",
			function()
				require("gitsigns").toggle_current_line_blame()
			end,
			desc = "Toggle Blame Line",
		},
		{
			"<leader>gtp",
			function()
				require("gitsigns").preview_hunk_inline()
			end,
			desc = "Toggle Deleted",
		},
	},
}
