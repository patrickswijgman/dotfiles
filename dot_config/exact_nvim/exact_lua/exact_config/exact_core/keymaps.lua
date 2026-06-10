-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Replace
vim.keymap.set("v", "R", '"_dP', { desc = "Replace selection with yanked text" })
vim.keymap.set("v", "<leader>R", '"_d"+P', { desc = "Replace selection with system clipboard" })

-- Plugins
vim.keymap.set("n", "<leader>e", "<cmd>Explorer<cr>", { desc = "Open explorer" })
vim.keymap.set("n", "<leader>f", ":Files ", { desc = "Search for files" })
vim.keymap.set("n", "<leader>g", ":Grep ", { desc = "Grep in files" })

-- Misc
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear highlight" })
