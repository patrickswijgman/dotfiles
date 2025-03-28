require("zen-mode").setup({
	window = {
		width = 120,
	},
})

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle zen mode" })
