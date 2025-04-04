require("dressing").setup({
	input = {
		relative = "editor",
		mappings = {
			i = {
				["<esc>"] = "Close",
			},
		},
	},
	select = {
		backend = { "telescope" },
	},
})
