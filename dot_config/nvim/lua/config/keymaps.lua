-- Set <leader> key to space.
vim.g.mapleader = " "

-- Clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipbard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })

-- Buffers.
vim.keymap.set("n", "<c-n>", "<cmd>new<cr>", { desc = "New buffer" })
vim.keymap.set("n", "<c-h>", "<cmd>bprev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<c-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<c-q>", "<cmd>bprev<cr><cmd>bdelete #<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<c-a>", "<c-^>", { desc = "Switch buffer" })

-- Tabs.
vim.keymap.set("n", "<a-n>", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<a-h>", "<cmd>tabprev<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<a-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<a-q>", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<a-a>", "g<tab>", { desc = "Switch tab" })

-- Pairs.
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix list item" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix list item" })

vim.keymap.set("n", "[l", "<cmd>lprev<cr>", { desc = "Previous location list item" })
vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { desc = "Next location list item" })

vim.keymap.set("n", "[b", "<cmd>bprev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "[t", "<cmd>tabprev<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- Misc.
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear search highlight", remap = true })

-- Disabled.
vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "Q", "<nop>")
