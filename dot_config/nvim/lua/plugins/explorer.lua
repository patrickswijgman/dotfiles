-- It is strongly advised to eagerly disable netrw, due to race conditions at vim startup.
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

require("nvim-tree").setup({
	view = {
		width = {}, -- A table indicates that the view should be dynamically sized based on the longest line.
	},
	renderer = {
		special_files = {}, -- This will not highlight e.g. README.md.
		icons = {
			git_placement = "signcolumn",
			modified_placement = "signcolumn",
			hidden_placement = "signcolumn",
			diagnostics_placement = "signcolumn",
			bookmarks_placement = "signcolumn",
		},
	},
	git = {
		enable = true,
	},
	diagnostics = {
		enable = true,
	},
	modified = {
		enable = true,
	},
})

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<cr>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Open file explorer to current file" })
