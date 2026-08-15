-- Global variables
vim.g.have_nerd_font = true

-- UI & Display
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.signcolumn = "auto"
vim.opt.wrap = false
vim.opt.inccommand = "split"
vim.opt.cmdheight = 0

-- Window Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tabs & Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search & Case Sensitivity
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Files, Undo & System
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.timeoutlen = 400
vim.opt.updatetime = 50

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})
