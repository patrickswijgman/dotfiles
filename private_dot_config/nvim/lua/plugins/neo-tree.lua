require("neo-tree").setup({
	sources = {
		"filesystem",
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true, -- Don't close auto-expanded dirs when using `Neotree reveal`.
		},
		filtered_items = {
			hide_dotfiles = false,
			hide_by_name = { ".git" },
		},
	},
	default_component_configs = {
		-- Disable all extra columns so only the file name remains (for projects with a lot of folders and long file names).
		file_size = {
			enabled = false,
		},
		type = {
			enabled = false,
		},
		last_modified = {
			enabled = false,
		},
		created = {
			enabled = false,
		},
		-- Do show if the item is a symlink.
		symlink_target = {
			enabled = true,
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal<cr>", { desc = "Neo-tree open" })
