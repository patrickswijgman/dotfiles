local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				-- Show mappings for picker actions with <c-/>.
				["<esc>"] = actions.close,
				["<c-down>"] = actions.cycle_history_next,
				["<c-up>"] = actions.cycle_history_prev,
				["<tab>"] = layout.toggle_preview,
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
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })

vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Telescope LSP definitions" })
vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { desc = "Telescope LSP type definitions" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Telescope LSP implementations" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Telescope LSP references" })
vim.keymap.set("n", "go", builtin.lsp_document_symbols, { desc = "Telescope LSP document symbols" })
vim.keymap.set("n", "gt", builtin.lsp_workspace_symbols, { desc = "Telescope LSP workspace symbols" })
vim.keymap.set("n", "ge", builtin.diagnostics, { desc = "Telescope LSP diagnostics" })
