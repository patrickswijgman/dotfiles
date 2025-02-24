local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				-- Close Telescope when pressing escape instead of going to normal mode.
				["<esc>"] = actions.close,
			},
		},
		-- Make it possible to grep in hidden files.
		vimgrep_arguments = {
			"rg",
			"--vimgrep",
			"--hidden",
			"--glob=!**/.git/*",
			"--sort=path",
		},
	},
	pickers = {
		find_files = {
			-- Include hidden files when searching for a file.
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--glob=!**/.git/*",
				"--sort=path",
			},
		},
	},
})

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>w", builtin.grep_string, { desc = "Telescope word grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
