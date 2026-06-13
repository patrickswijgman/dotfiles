---@type vim.lsp.Config
return {
  cmd = { "npx", "biome", "lsp-proxy" },
  filetypes = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "biome.json",
    "biome.jsonc",
  },
}
