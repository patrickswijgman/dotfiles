require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    javascript = { "biome", "prettierd", stop_after_first = true },
    typescript = { "biome", "prettierd", stop_after_first = true },
    javascriptreact = { "biome", "prettierd", stop_after_first = true },
    typescriptreact = { "biome", "prettierd", stop_after_first = true },
    html = { "biome", "prettierd", stop_after_first = true },
    css = { "biome", "prettierd", stop_after_first = true },
    json = { "biome", "prettierd", stop_after_first = true },
    jsonc = { "biome", "prettierd", stop_after_first = true },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    go = { "gofmt" },
    python = { "ruff" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
