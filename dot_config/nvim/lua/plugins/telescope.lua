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
		vimgrep_arguments = { "rg", "--vimgrep", "--hidden", "--glob=!**/.git/*" },
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob=!**/.git/*" },
		},
	},
})

-- Instead of live_grep, first grep with input and then use Telescope to filter results.
local function grep()
	vim.ui.input({ prompt = "Grep: " }, function(input)
		if input and input ~= "" then
			builtin.grep_string({ search = input })
		end
	end)
end

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find file" })
vim.keymap.set("n", "<leader>/", grep, { desc = "Find content (grep)" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find buffer" })
vim.keymap.set("n", "<leader>q", builtin.quickfix, { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Open last picker" })

vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to LSP definitions" })
vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { desc = "Go to LSP type definitions" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to LSP implementations" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to LSP references" })
vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { desc = "Go to LSP document symbols" })
vim.keymap.set("n", "gS", builtin.lsp_workspace_symbols, { desc = "Go to LSP workspace symbols" })
vim.keymap.set("n", "ge", builtin.diagnostics, { desc = "Go to LSP diagnostics" })
vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "Show spell suggestions" })
