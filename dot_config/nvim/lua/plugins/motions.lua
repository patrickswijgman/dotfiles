require("nvim-surround").setup({})

require("spider").setup({
	skipInsignificantPunctuation = true,
	consistentOperatorPending = false, -- See "Consistent Operator-pending Mode" in the README.
	subwordMovement = true,
})

-- For dot-repeat to work, you have to call the motions as Ex-commands. Dot-repeat will not work when using function() as the third argument.
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<cr>", { desc = "Spider w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<cr>", { desc = "Spider e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<cr>", { desc = "Spider b" })

-- Leap does not require setup, only keybindings.
-- Only set in normal mode to not clash with nvim-surround.
vim.keymap.set("n", "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
vim.keymap.set("n", "S", "<Plug>(leap-backward)", { desc = "Leap backward" })
vim.keymap.set("n", "gs", "<Plug>(leap-from-window)", { desc = "Leap from window" })
