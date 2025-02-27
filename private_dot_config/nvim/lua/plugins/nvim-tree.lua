-- It is strongly advised to eagerly disable netrw, due to race conditions at vim startup.
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

require("nvim-tree").setup({
	view = {
		-- A table indicates that the view should be dynamically sized based on the longest line.
		width = {},
	},
	update_focused_file = {
		enable = true,
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "Nvim-tree open" })
