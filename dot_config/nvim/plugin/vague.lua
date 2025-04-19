require("vague").setup({
	style = {
		boolean = "bold",
		number = "none",
		float = "none",
		error = "bold",
		comments = "italic",
		conditionals = "none",
		functions = "none",
		headings = "bold",
		operators = "none",
		strings = "none",
		variables = "none",

		keywords = "none",
		keyword_return = "none",
		keywords_loop = "none",
		keywords_label = "none",
		keywords_exception = "none",

		builtin_constants = "bold",
		builtin_functions = "none",
		builtin_types = "bold",
		builtin_variables = "none",
	},
})

vim.cmd.colorscheme("vague")

vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
	undercurl = true,
	sp = "#606079",
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {
	fg = "#606079",
	italic = true,
})
