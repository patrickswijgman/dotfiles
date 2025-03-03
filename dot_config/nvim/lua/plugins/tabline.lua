require("bufferline").setup({
	options = {
		offsets = {
			{ filetype = "NvimTree" },
		},
		show_buffer_close_icons = false, -- Use keymap instead.
		show_close_icon = false, -- Hide close button for tabpages as well
	},
	-- Integrate with colorscheme.
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
