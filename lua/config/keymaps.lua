-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymaps = vim.keymap
local opts = { noremaps = true, silent = true }

-- Select all
keymaps.set("n", "<C-a>", "gg<S-v>G")
