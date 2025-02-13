return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	enabled = true,
	config = function()
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}

		-- Set menu

		dashboard.section.buttons.val = {
			dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰈞   Find file", ":Telescope find_files<CR>"),
			dashboard.button("r", "   Recent files", ":Telescope oldfiles<CR>"),
			dashboard.button("l", "󰒲   Lazy", ":Lazy"),
			dashboard.button("s", "   Settings", ":e $MYVIMRC | :cd %:p:h | pwd<CR>"),
			dashboard.button("q", "󰩈   Quit NVIM", ":qa<CR>"),
		}

		-- dashboard.section.footer.val =
		-- "Go explore and build dumb things because, at the end of the day, it can genuinely help you in life"

		require("alpha").setup(dashboard.opts)
	end,
}
