vim.pack.add({
    -- treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },

    -- neotree
    {
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = vim.version.range("3"),
    },
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    "https://github.com/nvim-mini/mini.nvim",

    "https://github.com/ibhagwan/fzf-lua",

    "https://github.com/catgoose/nvim-colorizer.lua",

    "https://github.com/tpope/vim-sleuth",

    "https://github.com/rafamadriz/friendly-snippets",

    "https://github.com/craftzdog/solarized-osaka.nvim",

    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
})

-- Explicit load order: lsp.lua needs mini.completion, so mini goes first.
-- New plugin config files must be added to this list.
local modules = { "mini", "lsp", "treesitter", "fzf", "neo-tree", "colorizer" }

for _, name in ipairs(modules) do
    require("plugins." .. name)
end
