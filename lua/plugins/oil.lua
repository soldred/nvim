return {
	"stevearc/oil.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	lazy = false,
	keys = {
		{
			"-",
			function()
				vim.cmd("Oil")
			end,
			desc = "Open parent directory",
		},
	},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			columns = { "icon" },
			lsp_file_methods = {
				enabled = true,
				timeout_ms = 1000,
			},
		})
	end,
}
