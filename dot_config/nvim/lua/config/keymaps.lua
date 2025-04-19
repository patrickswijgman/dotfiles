vim.g.mapleader = " "

-- Motions
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down (including wrapped lines)", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up (including wrapped lines)", expr = true, silent = true })

-- Windows
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go to right window" })

-- Clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>P", [["+P]], { desc = "Paste from system clipboard" })

-- Misc
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear search highlight", remap = true })

-- Disabled
vim.keymap.set("n", "q", "<nop>", { desc = "Disable macros" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable macros" })
