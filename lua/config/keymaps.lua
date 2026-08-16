vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "x", '"_x', opts) -- Delete without copying to register
vim.keymap.set("v", "p", '"_dP', opts) -- Paste without losing yanked text

-- Window navigation (splits)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- Tab navigation
vim.keymap.set("n", "<leader>tc", "<cmd>tabnew<CR>", { desc = "Create tab" })
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<CR>", { desc = "Delete tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Identation, lines and navigations
vim.keymap.set("v", "J", "<cmd>m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", "<cmd>m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result with cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result with cursor centered" })

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })
vim.keymap.set("v", "<leader>r", [["hy:%s/\V<C-r>h/<C-r>h/gI<Left><Left><Left>]], { desc = "Replace visual selection globally" })

-- Other
vim.keymap.set("i", "<C-c>", "Esc", opts)

-- native undotree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })

