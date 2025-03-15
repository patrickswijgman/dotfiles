require("colorizer").setup({
	filetypes = { "html", "css", "typescript", "typescriptreact" },
	user_default_options = {
		css = true,
		css_fn = true,
		tailwind = "lsp",
		mode = "virtualtext",
		virtualtext = "■",
		virtualtext_inline = "after",
		virtualtext_mode = "foreground",
	},
})

require("which-key").setup({
	preset = "helix",
	spec = {
		{ "<leader>gy", desc = "Copy git repository link" },
	},
	plugins = {
		spelling = {
			enabled = false, -- Use Telescope for spelling suggestions.
		},
	},
	icons = {
		mappings = false,
	},
	show_help = false,
})

require("zen-mode").setup({
	window = {
		width = 1, -- 100% width.
	},
})

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle zen mode" })
