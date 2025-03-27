-- It is strongly advised to eagerly disable netrw, due to race conditions at vim startup.
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

require("nvim-tree").setup({
	view = {
		-- A table indicates that the view should be dynamically sized based on the longest line.
		width = {},
	},
	renderer = {
		-- This will not highlight e.g. README.md.
		special_files = {},
	},
	git = {
		enable = false,
	},
	live_filter = {
		always_show_folders = false,
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFile<cr>", { desc = "Open file explorer" })
