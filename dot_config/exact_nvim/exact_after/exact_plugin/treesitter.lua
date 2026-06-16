require("treesitter").setup({
  path = os.getenv("TREESITTER_PATH"),
  registrations = {
    { "tsx", "typescriptreact" },
  },
})
