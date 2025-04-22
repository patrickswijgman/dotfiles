require("lsp-extra").setup({
  auto_enable = true,
  hover = {
    border = "rounded",
  },
  signature_help = {
    border = "rounded",
  },
  disable_semantic_tokens = true,
  remove_default_keymaps = true,
  keymaps = {
    code_action = "<leader>a",
    rename = "<leader>r",
    signature_help = "<c-s>",
    hover = "K",
  },
})
