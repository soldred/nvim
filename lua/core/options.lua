vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.scrolloff = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.timeoutlen = 400
vim.opt.updatetime = 250
vim.opt.ttyfast = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.linebreak = true

-- Sync system clipboard with neovim one
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
