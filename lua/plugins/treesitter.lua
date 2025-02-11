return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = { "bash", "diff", "lua", "luadoc", "vim", "vimdoc", "c", "cpp", "python", "sql", "regex", "xml", "yaml", "javascript", "json", "jsonc", "typescript","markdown", "markdown_inline", "php", "html", "css"},
		auto_install = true,
		sync_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { 'ruby' },
		},
		indent = { enable = true, disable = { "ruby" } }
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end
}
