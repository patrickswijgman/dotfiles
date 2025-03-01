require("colorizer").setup({
	filetypes = { "html", "css", "typescript", "typescriptreact" },
	user_default_options = {
		css = true,
		css_fn = true,
		tailwind = "both", -- Determine with both normal and LSP.
		tailwind_opts = {
			update_names = true, -- When using tailwind = 'both', update tailwind names from LSP results. See tailwind section.
		},
		mode = "virtualtext",
		virtualtext = "■",
		virtualtext_inline = "after",
		virtualtext_mode = "foreground",
	},
})

require("which-key").setup({})

require("zen-mode").setup({
	window = {
		width = 120,
	},
})

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
