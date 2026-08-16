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

    "https://github.com/catgoose/nvim-colorizer.lua",

    "craftzdog/solarized-osaka.nvim",
})

local path = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.glob(path .. "/*.lua", false, true)) do
    local name = vim.fn.fnamemodify(file, ":t:r")

    if name ~= "init" then
        require("plugins." .. name)
    end
end
