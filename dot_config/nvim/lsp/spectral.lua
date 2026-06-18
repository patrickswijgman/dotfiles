---@type vim.lsp.Config
return {
  cmd = { "spectral-language-server", "--stdio" },
  filetypes = {
    "yaml",
    "yml",
  },
  root_markers = {
    ".spectral.yaml",
    ".spectral.yml",
    ".spectral.json",
    ".spectral.js",
  },
  settings = {
    enable = true,
    run = "onType",
    validateLanguages = { "yaml", "yml" },
  },
}
