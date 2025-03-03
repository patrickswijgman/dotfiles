require("bufferline").setup({
	options = {
		offsets = {
			{ filetype = "NvimTree" },
		},
		show_buffer_close_icons = false, -- Use keymap instead.
	},
	-- Integrate with colorscheme.
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
