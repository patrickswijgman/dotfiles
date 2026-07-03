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
    python = { "ruff" },
    go = { "gofmt" },
    _ = { "trim_whitespace" },
  },
})

local function format(ev)
  require("bulb").code_action({
    bufnr = ev.buf,
    kinds = { "source.fixAll.biome" },
  })

  require("conform").format({
    bufnr = ev.buf,
    lsp_format = "fallback",
    timeout_ms = 1000,
  })
end

local group = vim.api.nvim_create_augroup("FormatConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = format,
  desc = "Format before save",
  group = group,
})
