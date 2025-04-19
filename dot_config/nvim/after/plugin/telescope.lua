local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

telescope.setup({
	defaults = {
		layout_config = {
			horizontal = {
				prompt_position = "top",
				width = { padding = 0 },
				height = { padding = 0 },
				preview_width = 0.5,
			},
		},
		sorting_strategy = "ascending",
		path_display = {
			"filename_first",
		},
		mappings = {
			i = {
				["<c-up>"] = actions.cycle_history_prev,
				["<c-down>"] = actions.cycle_history_next,
				["<tab>"] = layout.toggle_preview,
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
vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Resume previous picker" })

vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to LSP definitions" })
vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { desc = "Go to LSP type definitions" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to LSP references" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to LSP implementations" })
vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { desc = "LSP document symbols" })
vim.keymap.set("n", "gS", builtin.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
vim.keymap.set("n", "ge", builtin.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "Spell suggestions" })
