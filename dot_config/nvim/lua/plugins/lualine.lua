require("lualine").setup({
	options = {
		section_separators = "",
		component_separators = "",
		disabled_filetypes = {
			statusline = { "NvimTree", "spectre_panel" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {},
		lualine_c = { "diagnostics", { "filename", path = 1 } },
		lualine_x = { "filetype", "location" },
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})
