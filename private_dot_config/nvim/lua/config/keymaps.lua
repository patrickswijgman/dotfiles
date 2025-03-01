-- Set <leader> key to space.
vim.g.mapleader = " "

-- Clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })

-- Buffer.
vim.keymap.set("n", "<a-n>", "<cmd>new<cr>", { desc = "Buffer prev" })
vim.keymap.set("n", "<a-h>", "<cmd>bprev<cr>", { desc = "Buffer prev" })
vim.keymap.set("n", "<a-h>", "<cmd>bprev<cr>", { desc = "Buffer prev" })
vim.keymap.set("n", "<a-l>", "<cmd>bnext<cr>", { desc = "Buffer next" })
vim.keymap.set("n", "<a-q>", "<cmd>buffer #<cr><cmd>bdelete #<cr>", { desc = "Buffer close" })
vim.keymap.set("n", "<a-a>", "<cmd>buffer #<cr>", { desc = "Buffer alternate" })

-- Windows.
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Window left" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Window down" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Window up" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Window right" })
vim.keymap.set("n", "<c-q>", "<c-w>q", { desc = "Window close" })

-- Pairs.
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Quickfix list prev" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Quickfix list next" })
vim.keymap.set("n", "[l", "<cmd>lprev<cr>", { desc = "Location list prev" })
vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { desc = "Location list next" })
vim.keymap.set("n", "[b", "<cmd>bprev<cr>", { desc = "Buffer prev" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Buffer next" })
vim.keymap.set("n", "[t", "<cmd>tabprev<cr>", { desc = "Tab prev" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Tab next" })

-- Misc.
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear search highlight", remap = true })

-- Disabled.
vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "Q", "<nop>")
