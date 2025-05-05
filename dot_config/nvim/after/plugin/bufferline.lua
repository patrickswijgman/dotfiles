require("bufferline").setup({})

vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<cr>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<cr>", { desc = "Go to next buffer" })
vim.keymap.set("n", "Q", "<cmd>bprev<bar>bdelete #<cr>", { desc = "Delete current buffer" })
