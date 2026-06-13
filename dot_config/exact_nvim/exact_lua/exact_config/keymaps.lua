vim.keymap.set("n", "<leader>e", ":Explorer<cr>", { desc = "Open explorer" })
vim.keymap.set("n", "<leader>f", ":Files ", { desc = "Search for files" })
vim.keymap.set("n", "<leader>g", ":Grep ", { desc = "Grep in files" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>q", ":copen<cr>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<c-j>", ":cnext<cr>zz", { desc = "Previous quickfix item and center view" })
vim.keymap.set("n", "<c-k>", ":cprev<cr>zz", { desc = "Next quickfix item and center view" })

vim.keymap.set("v", "R", '"_dP', { desc = "Replace selection with yanked text" })
vim.keymap.set("v", "<leader>R", '"_d"+P', { desc = "Replace selection with system clipboard" })

vim.keymap.set("n", "<c-d>", "<c-d>zz", { desc = "Scroll down and center view" })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { desc = "Scroll up and center view" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Find next pattern, center view and open fold" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Find previous pattern, center view and open fold" })

vim.keymap.set("n", "<esc>", ":nohl<cr>", { desc = "Clear highlight", silent = true })

vim.keymap.set("n", "q", "<nop>", { desc = "Disable recording" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable recording" })
