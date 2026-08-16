require("colorizer").setup({
    filetypes = { "*" },

    options = {
        parsers = {
            hex = {
                default = false,
                rgb = true,
                rgba = true,
                rrggbb = true,
                rrggbbaa = true,
                aarrggbb = false,
            },

            rgb = { enable = true },
            hsl = { enable = true },

            -- names = { enable = false },
            tailwind = { enable = true },
            sass = { enable = false },
        },

        display = {
            mode = "virtualtext",

            virtualtext = {
                char = "■",
                position = "after",
                hl_mode = "foreground",
            },
        },
    },
})
