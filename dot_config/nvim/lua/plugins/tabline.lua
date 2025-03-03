require("bufferline").setup({
	options = {
		offsets = {
			{ filetype = "NvimTree" },
		},
		show_buffer_close_icons = false,
		show_close_icon = false,
	},
	-- Integrate with colorscheme.
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
