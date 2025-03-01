require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = {
		light = "latte",
		dark = "mocha",
	},

	no_italic = false,
	no_bold = false,
	no_underline = false,

	-- Handles the styles of general highlight groups (see `:h highlight-args`)
	styles = {
		comments = { "italic" },
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},

	default_integrations = true,
	integrations = {
		fidget = true,
		leap = true,
		neotest = true,
		nvim_surround = true,
		which_key = true,
		-- For more plugins integrations see https://github.com/catppuccin/nvim#integrations
	},
})

vim.cmd.colorscheme("catppuccin")
