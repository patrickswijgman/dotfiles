require("conform").setup({
  formatters_by_ft = {
    javascript = { "biome", "prettierd", stop_after_first = true },
    typescript = { "biome", "prettierd", stop_after_first = true },
    javascriptreact = { "biome", "prettierd", stop_after_first = true },
    typescriptreact = { "biome", "prettierd", stop_after_first = true },
    html = { "biome", "prettierd", stop_after_first = true },
    css = { "stylelint", "biome" },
    json = { "biome", "prettierd", stop_after_first = true },
    jsonc = { "biome", "prettierd", stop_after_first = true },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    toml = { "taplo" },
    python = { "ruff_organize_imports", "ruff_format" },
    go = { "gofmt" },
    lua = { "stylua" },
    nix = { "nixfmt" },
    _ = { "trim_whitespace" },
  },
})

local function apply_code_actions_and_format(ev)
  require("bulb").code_action({
    bufnr = ev.buf,
    kinds_by_server = { biome = { "source.fixAll.biome" } },
    timeout_ms = 1000,
  })

  require("conform").format({
    bufnr = ev.buf,
    lsp_format = "fallback",
    timeout_ms = 1000,
  })
end

local group = vim.api.nvim_create_augroup("FormatConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = apply_code_actions_and_format,
  desc = "Apply code actions and format before save",
  group = group,
})
