require("blink.cmp").setup({
	keymap = {
		preset = "enter",
	},
	completion = {
		documentation = {
			auto_show = true,
		},
	},
	signature = {
		enabled = true,
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})
