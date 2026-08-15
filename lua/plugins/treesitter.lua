local ts = require("nvim-treesitter")
local textobjects = require("nvim-treesitter-textobjects")

ts.install({
	"go", "rust", "typescript", "javascript", "tsx", "lua",
	"html", "css", "json", "json5", "bash", "http", "dockerfile", "sql",
})

textobjects.setup({
	select = { lookahead = true },
})

local select = require("nvim-treesitter-textobjects.select")
local swap = require("nvim-treesitter-textobjects.swap")

local objects = {
	["if"] = "@function.inner",
	["af"] = "@function.outer",
    ["ia"] = "@parameter.inner",
	["aa"] = "@parameter.outer",
    ["ac"] = "@comment.outer",
	["ic"] = "@comment.inner",
    ["at"] = "@tag.outer",
	["it"] = "@tag.inner",
	["al"] = "@loop.outer",
    ["il"] = "@loop.inner",
	["a?"] = "@conditional.outer",
	["i?"] = "@conditional.inner",
}

for key, query in pairs(objects) do
	vim.keymap.set({ "x", "o" }, key, function()
		select.select_textobject(query, "textobjects")
	end)
end

vim.keymap.set("n", "<leader>a", function()
	swap.swap_next("@parameter.inner")
end)

vim.keymap.set("n", "<leader>A", function()
	swap.swap_previous("@parameter.inner")
end)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if lang then
			pcall(vim.treesitter.start, args.buf, lang)
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 1,
})
