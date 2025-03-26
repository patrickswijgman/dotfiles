local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<c-down>"] = actions.cycle_history_next,
				["<c-up>"] = actions.cycle_history_prev,
				["<tab>"] = layout.toggle_preview,
			},
		},
		vimgrep_arguments = { "rg", "--vimgrep", "--smart-case", "--hidden", "--glob=!**/.git/*" },
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--smart-case", "--hidden", "--glob=!**/.git/*" },
		},
	},
})

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find file" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Find content (grep)" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to LSP definitions" })
vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { desc = "Go to LSP type definitions" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to LSP implementations" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to LSP references" })
vim.keymap.set("n", "go", builtin.lsp_document_symbols, { desc = "Go to LSP document symbols" })
vim.keymap.set("n", "gt", builtin.lsp_workspace_symbols, { desc = "Go to LSP workspace symbols" })
vim.keymap.set("n", "ge", builtin.diagnostics, { desc = "Go to LSP diagnostics" })
vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "Show spell suggestions" })
