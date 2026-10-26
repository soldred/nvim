---- mini notify ----
require("mini.notify").setup({
    -- only show messages
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

--- mini cmdline completion ---
require("mini.cmdline").setup({
    autocorrect = { enable = false },
})

--- mini surround ---
require("mini.surround").setup()
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |

-- mini clue ---
local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = { "n", "x" }, keys = "<Leader>" },

        -- `[` and `]` keys
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = { "n", "x" }, keys = "g" },

        -- Marks
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },

        -- Registers
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = { "n", "x" }, keys = "z" },
    },
    window = {
        delay = 300,
    },
    clues = {
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})

-- mini diff --
local MiniDiff = require("mini.diff")
MiniDiff.setup({
    source = MiniDiff.gen_source.git({ index = false }),
})

--- mini completion ---
local minicompletion = require("mini.completion")
minicompletion.setup({
    lsp_completion = {
        auto_setup = true,
    },
})

local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
    },
})
MiniSnippets.start_lsp_server({ match = false })
