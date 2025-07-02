return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local colorizer = require("colorizer")

		colorizer.setup({
			user_default_options = {
				tailwind = true,
				names = true,
				RGB = true,
				RRGGBB = true,
				AARRGGBB = true,
				css = true,
				css_fn = true,
				mode = "background",
			},
			filetypes = {
				"css",
				"scss",
				"sass",
				"html",
				"javascript",
				"typescript",
				"jsx",
				"tsx",
				"vue",
				"svelte",
			},
		})

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			callback = function()
				vim.cmd("ColorizerAttachToBuffer")
			end,
		})
	end,
}
