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
		documentation = {
			auto_show = true,
		},
	},
	signature = {
		enabled = true,
	},
})
