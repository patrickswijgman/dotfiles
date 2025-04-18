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
