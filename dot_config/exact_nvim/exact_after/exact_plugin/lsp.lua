require("lsp").setup({
  enabled = {
    "biome",
    "codebook",
    "efm",
    "fish_lsp",
    "jsonls",
    "lua_ls",
    "nixd",
    "vtsls",
  },
  format = true,
  formatter_priority = {
    "biome",
    "efm",
  },
  code_actions = {
    biome = {
      "source.fixAll.biome",
    },
  },
  semantic_tokens = false,
  auto_complete = true,
  auto_complete_auto_trigger = true,
  timeout_ms = 1000,
})
