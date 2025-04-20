require("lsp-loader").setup({
  hover = {
    border = "rounded",
  },
  disable_semantic_tokens = true,
})

vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "LSP code action" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP rename" })
