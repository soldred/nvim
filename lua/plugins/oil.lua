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

		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
				end
			end,
		})
	end,
}
