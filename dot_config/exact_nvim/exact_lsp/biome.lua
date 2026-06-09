---@type vim.lsp.Config
return {
  cmd = { "npx", "biome", "lsp-proxy" },
  filetypes = {
    "astro",
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "svelte",
    "typescript",
    "typescriptreact",
    "vue",
  },
  root_markers = { "biome.json", "biome.jsonc" },
}
