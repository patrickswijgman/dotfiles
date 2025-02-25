local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				-- Close Telescope when pressing escape instead of going to normal mode.
				["<esc>"] = actions.close,
				-- Cycle through history, not included by default.
				["<c-down>"] = actions.cycle_history_next,
				["<c-up>"] = actions.cycle_history_prev,
			},
		},
		-- Make it possible to grep in hidden files.
		vimgrep_arguments = {
			"rg",
			"--vimgrep",
			"--sort=path",
			"--smart-case",
			"--hidden",
			"--glob=!**/.git/*",
		},
	},
	pickers = {
		find_files = {
			-- Make it possible to pick a hidden file.
			find_command = {
				"rg",
				"--files",
				"--sort=path",
				"--smart-case",
				"--hidden",
				"--glob=!**/.git/*",
			},
		},
	},
})

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>w", builtin.grep_string, { desc = "Telescope word grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
