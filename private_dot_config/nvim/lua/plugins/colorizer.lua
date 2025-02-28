require("colorizer").setup({
	filetypes = { "html", "css", "typescript", "typescriptreact" },
	user_default_options = {
		-- CSS colors.
		css = true, -- Enable all CSS *features*: names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
		css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

		-- Tailwind colors. boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
		tailwind = "both", -- Enable tailwind colors
		tailwind_opts = { -- Options for highlighting tailwind names
			update_names = true, -- When using tailwind = 'both', update tailwind names from LSP results. See tailwind section
		},

		-- Highlighting mode. 'background'|'foreground'|'virtualtext'
		mode = "virtualtext",
		-- Virtualtext character to use
		virtualtext = "■",
		-- Display virtualtext inline with color. boolean|'before'|'after'.  True sets to 'after'
		virtualtext_inline = "after",
		-- Virtualtext highlight mode: 'background'|'foreground'
		virtualtext_mode = "foreground",
	},
})
