require("bufferline").setup({
  options = {
    sort_by = "insert_at_end",
    offsets = {
      { filetype = "NvimTree" },
    },
  },
})

vim.keymap.set("n", "<c-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<c-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<c-q>", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<c-tab>", "<cmd>buffer #<cr>", { desc = "Alternate buffer" })
