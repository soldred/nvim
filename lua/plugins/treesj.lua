return {
	"Wansmer/treesj",
	lazy = true,
	cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
	keys = {
		{ "gj", "<cmd>TSJToggle<CR>", desc = "Toggle split/join" },
	},
	opts = {
		use_default_keymaps = false,
	},
}
