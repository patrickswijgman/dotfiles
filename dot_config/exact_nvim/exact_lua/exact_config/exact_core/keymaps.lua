vim.keymap.set('n', '<leader>f', '<cmd>FZF<cr>', { desc = "Open file picker" })

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = "Paste from system clipboard" })

vim.keymap.set('v', 'R', '"_dP', { desc = 'Replace selection with yanked text' })
vim.keymap.set('v', '<leader>R', '"_d"+P', { desc = 'Replace selection with system clipboard' })

vim.keymap.set('n', '<esc>', '<cmd>nohl<cr>', { desc = "Clear highlight" })
