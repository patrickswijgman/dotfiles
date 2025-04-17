local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
		vimgrep_arguments = { "rg", "--vimgrep", "--hidden", "--glob=!**/.git/*" },
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type=file", "--hidden", "--exclude=.git" },
		},
	},
})

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find file" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep content" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find buffer" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Find help" })
