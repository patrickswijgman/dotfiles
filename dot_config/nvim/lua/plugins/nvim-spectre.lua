require("spectre").setup({
	open_cmd = "tabnew",
})

vim.keymap.set("n", "<leader>s", "<cmd>Spectre<cr>", { desc = "Open find and replace" })
