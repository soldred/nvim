-- The main entry point for the Neovim configuration.
-- It's responsible for setting global variables and bootstrapping
-- the core modules in the correct order.

require("core.options")
require("core.keymaps")
require("core.lazy")
