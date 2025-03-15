require("bufferline").setup({
	options = {
		offsets = {
			{ filetype = "NvimTree" },
		},
		diagnostics = "nvim_lsp",
		show_buffer_close_icons = false,
		show_close_icon = false,
		sort_by = "insert_after_current",
	},
	-- Integrate with colorscheme.
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})

vim.keymap.set("n", "<c-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<c-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

require("bufdel").setup({
	next = "alternate",
	quit = false, -- Don't close Neovim when closing the last buffer.
})

vim.keymap.set("n", "<c-q>", "<cmd>BufDel<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<c-del>", "<cmd>BufDelAll<cr>", { desc = "Close all buffers" })
