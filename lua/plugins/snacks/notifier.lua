return {
	"snacks.nvim",
	opts = {
		notifier = {
			timeout = 3000,
		},
	},
	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification history",
		},
	},
}
