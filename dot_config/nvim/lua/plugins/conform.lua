require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettierd", "biome" },
    typescript = { "prettierd", "biome" },
    javascriptreact = { "prettierd", "biome" },
    typescriptreact = { "prettierd", "biome" },
    html = { "prettierd" },
    css = { "prettierd" },
    json = { "prettierd", "biome" },
    jsonc = { "prettierd", "biome" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
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
