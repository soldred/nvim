-- [[ Core options ]]

local options = {
	-- UI / Visuals
	number = true,
	relativenumber = true,
	termguicolors = true,
	cursorline = true,
	scrolloff = 8,
	showmode = false,
	splitright = true,
	splitbelow = true,
	signcolumn = "auto",

	-- Tabs & Indentation
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	smartindent = true,
	autoindent = true,
	breakindent = true,

	-- Search
	hlsearch = true,
	incsearch = true,
	ignorecase = true,
	smartcase = true,

	-- Editor Behavior
	mouse = "a",
	clipboard = "unnamedplus",
	wrap = false,
	inccommand = "split",

	-- System & Performance
	undofile = true,
	swapfile = false,
	backup = false,
	timeoutlen = 400,
	updatetime = 50,
}

-- Apply options from the table
for k, v in pairs(options) do
	vim.opt[k] = v
end

-- [[ Autocommands ]]
-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
