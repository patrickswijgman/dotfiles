-- It is strongly advised to eagerly disable netrw, due to race conditions at vim startup.
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

require("nvim-tree").setup({
	reload_on_bufenter = true,
	view = {
		width = {}, -- A table indicates that the view should be dynamically sized based on the longest line.
	},
	renderer = {
		special_files = {}, -- This will not highlight e.g. README.md.
		indent_markers = {
			enable = false,
		},
	},
	git = {
		enable = false,
	},
	live_filter = {
		always_show_folders = false,
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { desc = "Open current file in file explorer" })
