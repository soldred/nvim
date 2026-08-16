require("fzf-lua").setup({
	"fzf-native",
})

local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader><space>", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>,", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Grep" })

vim.keymap.set("n", "<leader>sr", fzf.oldfiles, { desc = "Recent Files" })

vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", fzf.grep_cword, { desc = "Grep Word" })

vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "Help" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "Keymaps" })

vim.keymap.set("n", "<leader>gs", fzf.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gb", fzf.git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", fzf.git_commits, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gd", fzf.git_diff, { desc = "Git Diff" })
