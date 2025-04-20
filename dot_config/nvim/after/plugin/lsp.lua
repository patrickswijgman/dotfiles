require("lsp-loader").setup({
  hover = {
    border = "rounded",
  },
  signature_help = {
    title = "",
    border = "rounded",
  },
  disable_semantic_tokens = true,
  remove_default_keymaps = true,
  keymaps = {
    code_action = "<leader>a",
    rename = "<leader>r",
  },
})
