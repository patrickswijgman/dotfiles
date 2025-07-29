require("nvim-tree").setup({
  view = {
    width = {},
  },
  git = {
    enable = false,
  },
  modified = {
    enable = true,
  },
  filters = {
    enable = false,
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeOpen<cr>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { desc = "Open file explorer at current file" })
