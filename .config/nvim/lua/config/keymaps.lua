-- Windows
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Go to below window" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go to right window" })

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Replace
vim.keymap.set("v", "R", '"_dP', { desc = "Replace selection with yanked text" })
vim.keymap.set("v", "<leader>R", '"_d"+P', { desc = "Replace selection with system clipboard" })

-- Misc
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear highlight", silent = true })

-- Disabled
vim.keymap.set("n", "q", "<nop>", { desc = "Disable record macro" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable record macro" })
vim.keymap.set("n", "U", "<nop>", { desc = "Disable undo line changes" })
