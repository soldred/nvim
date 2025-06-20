return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		picker = { enabled = true },
		dashboard = { enabled = true },
		indent = {
			enabled = true,
			animate = {
				enabled = true,
			},
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		rename = { enabled = true },
	},
}
