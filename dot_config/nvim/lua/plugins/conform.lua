require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier", "biome" },
    typescript = { "prettier", "biome" },
    javascriptreact = { "prettier", "biome" },
    typescriptreact = { "prettier", "biome" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier", "biome" },
    jsonc = { "prettier", "biome" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    lua = { "stylua" },
    nix = { "nixfmt" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    toml = { "taplo" },
    _ = { "trim_whitespace" },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_format = "fallback",
  },
})
