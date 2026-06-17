local path = os.getenv("TREESITTER_PATH")

require("treesitter").setup({
  path = path,
  registrations = {
    { "tsx", "typescriptreact" },
  },
})
