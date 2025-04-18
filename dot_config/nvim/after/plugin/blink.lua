require("blink.cmp").setup({
	keymap = {
		preset = "enter",
	},
	completion = {
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},
		menu = {
			border = "rounded",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 50,
			window = {
				border = "rounded",
			},
		},
	},
	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},
})
