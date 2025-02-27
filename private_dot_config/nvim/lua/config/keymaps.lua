-- Set <leader> key to space.
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })

vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Quickfix next" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Quickfix prev" })

vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear search highlight", remap = true })
