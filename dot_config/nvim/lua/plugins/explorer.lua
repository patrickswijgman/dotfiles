-- It is strongly advised to eagerly disable netrw, due to race conditions at vim startup.
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

require("nvim-tree").setup({
	view = {
		width = {}, -- A table indicates that the view should be dynamically sized based on the longest line.
	},
	renderer = {
		special_files = {}, -- This will not highlight e.g. README.md.
	},
	git = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
	modified = {
		enable = false,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
	live_filter = {
		always_show_folders = false,
	},
})

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<cr>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Open file explorer to current file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapseKeepBuffers<cr>", { desc = "Collapse file explorer (keep buffers)" })
vim.keymap.set("n", "<leader>eq", "<cmd>NvimTreeClose<cr>", { desc = "Close file explorer" })
