vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<c-h>", "<cmd>tabprev<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<c-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<c-n>", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<c-q>", "<cmd>tabclose<cr>", { desc = "Close tab" })

vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear search highlight", remap = true })
