require("bufferline").setup({})

vim.keymap.set("n", "<c-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<c-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<c-q>", "<cmd>bprev<bar>bdelete #<cr>", { desc = "Delete current buffer" })
