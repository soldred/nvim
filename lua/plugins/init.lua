vim.pack.add({
    -- treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context", branch = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },

    -- neotree
    {
        src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
        version = vim.version.range('3')
    },
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    
    "https://github.com/nvim-mini/mini.nvim",

    "https://github.com/ibhagwan/fzf-lua",

    "craftzdog/solarized-osaka.nvim",
})

