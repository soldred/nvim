return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			opts = {
				custom_calculation = function(node, language_tree)
					if vim.bo.filetype == "blade" then
						return "{{-- %s --}}"
						end
					end,
				},
			},
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = {
					enable = true,
					max_lines = 1,
				},
			},

			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			ensure_installed = { "bash", "diff", "lua", "c", "cpp", "python", "sql", "javascript", "json", "jsonc", "typescript", "php", "html", "css", "dockerfile", "blade", "svelte", "vue", "go" },
			auto_install = true,
			sync_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby"} },
			textobjects = {
				select = {
					select = {
						enable = true,
						lookahed = true,
						keymaps = {
							["if"] = "@function.inner",
							["af"] = "@function.outer",
							["ia"] = "@parameter.inner",
							["aa"] = "@parameter.outer",
							["ac"] = "@comment.outer",
							["ic"] = "@comment.inner",
							-- For HTML/JSX/Vue/Svelte
							["at"] = "@tag.outer",
							["it"] = "@tag.inner",
							-- For cycles and conditions
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["a?"] = "@conditional.outer",
							["i?"] = "@conditional.inner",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},
			},
		},

		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.blade = {
				install_info = {
					url = "https://github.com/EmranMR/tree-sitter-blade",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "blade",
			},
			vim.filetype.add({
				pattern = {
					[".*%.blade%.php"] = "blade",
				},
			})
		end,
	}

