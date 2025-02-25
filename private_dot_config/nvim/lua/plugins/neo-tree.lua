require("neo-tree").setup({
	filesystem = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true, -- Don't close auto-expanded dirs when using `Neotree reveal`
		},
		filtered_items = {
			hide_dotfiles = false,
			hide_by_name = { ".git" },
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal<cr>", { desc = "Neo-tree open" })
