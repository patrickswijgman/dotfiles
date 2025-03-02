require("bufferline").setup({
	options = {
		mode = "tabs", -- Show tabs instead of buffers.
		offsets = {
			{ filetype = "NvimTree" },
		},
		show_buffer_close_icons = false, -- Use keymap instead.
	},
	-- Integrate with colorscheme.
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
