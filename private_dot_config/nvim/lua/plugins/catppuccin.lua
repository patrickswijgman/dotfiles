require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},

	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline

	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
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
		copilot_vim = true,
		nvim_surround = true,
		-- For more plugins integrations see https://github.com/catppuccin/nvim#integrations
	},
})

vim.cmd.colorscheme("catppuccin")
