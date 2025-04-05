require("lualine").setup({
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "NvimTree", "spectre_panel" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {},
		lualine_c = { "lsp_status", "diagnostics", { "filename", path = 1 } },
		lualine_x = { "filetype", "progress", "location" },
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
