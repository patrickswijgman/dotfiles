require("lsp").setup({
  -- LSP servers to enable (passed to vim.lsp.enable)
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

  -- Order of preference for formatting; first available client wins
  formatter_priority = { "biome", "efm" },

  -- Code actions to apply before formatting, keyed by client name
  code_actions = {
    biome = { "source.fixAll.biome" },
  },

  -- Enable semantic tokens
  -- Set this to false if you want to use treesitter instead
  semantic_tokens = false,

  -- Enable built-in completion (vim.lsp.completion)
  auto_complete = true,
  auto_complete_auto_trigger = true,
})
