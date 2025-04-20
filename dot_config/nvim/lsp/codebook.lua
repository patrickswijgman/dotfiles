--- @type vim.lsp.Config
return {
  cmd = { "codebook-lsp", "serve" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "html",
    "css",
    "go",
    "rust",
    "python",
    "nix",
    "lua",
    "markdown",
    "toml",
  },
  root_markers = {
    ".codebook.toml",
    "codebook.toml",
  },
}
