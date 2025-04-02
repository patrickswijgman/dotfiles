require("spider").setup({
	skipInsignificantPunctuation = false,
	consistentOperatorPending = false,
	subwordMovement = true,
})

-- For dot-repeat to work, you have to call the motions as Ex-commands.
-- Dot-repeat will not work when using a function as third argument.
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<cr>", { desc = "Spider motion w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<cr>", { desc = "Spider motion e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<cr>", { desc = "Spider motion b" })
