---@type vim.lsp.Config
return {
  cmd = { "efm-langserver" },
  filetypes = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  root_markers = {
    ".git",
  },
  init_options = {
    documentFormatting = true,
  },
}
