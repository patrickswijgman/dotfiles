-- Set <leader> key to space.
vim.g.mapleader = " "

-- Clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })

vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Quickfix prev" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Quickfix next" })

-- Tabs.
vim.keymap.set("n", "<c-n>", "<cmd>tabnew<cr>", { desc = "Tab new" })
vim.keymap.set("n", "<a-h>", "<cmd>tabprev<cr>", { desc = "Tab prev" })
vim.keymap.set("n", "<a-l>", "<cmd>tabnext<cr>", { desc = "Tab next" })
vim.keymap.set("n", "<a-q>", "<cmd>tabclose<cr>", { desc = "Tab close" })
vim.keymap.set("n", "<a-tab>", "g<tab>", { desc = "Tab switch" })

vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear search highlight", remap = true })
