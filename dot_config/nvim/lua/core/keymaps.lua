vim.g.mapleader = " "

-- Motions
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down (including wrapped lines)", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up (including wrapped lines)", expr = true, silent = true })
vim.keymap.set("n", "gh", "^", { desc = "Go to start of line" })
vim.keymap.set("n", "gl", "$", { desc = "Go to end of line" })

-- Windows
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go to right window" })
vim.keymap.set("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>P", [["+P]], { desc = "Paste from system clipboard" })

-- Quickfix list
vim.keymap.set("n", "<leader>q", "<cmd>botright copen<cr>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>Q", "<cmd>cclose<cr>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<c-n>", "<cmd>cnext<cr>", { desc = "Next quicklist item" })
vim.keymap.set("n", "<c-p>", "<cmd>cprev<cr>", { desc = "Previous quicklist item" })

-- General
vim.keymap.set("n", "<leader>f", ":Find ", { desc = "Find file" })
vim.keymap.set("n", "<leader>/", ":Grep ", { desc = "Grep content" })
vim.keymap.set("n", "<leader>b", ":buffer ", { desc = "Open buffer" })
vim.keymap.set("n", "<leader>e", "<cmd>Files<cr>", { desc = "Manage files" })

-- LSP
vim.keymap.set("i", "<c-space>", vim.lsp.completion.get, { desc = "Get LSP completion" })

-- Misc
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear search highlight", remap = true })

-- Disabled
vim.keymap.set("n", "q", "<nop>", { desc = "Disable macros" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable macros" })
