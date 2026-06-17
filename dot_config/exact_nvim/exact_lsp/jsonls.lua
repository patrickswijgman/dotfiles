---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = {
    "json",
    "jsonc",
  },
  root_markers = {
    ".git",
  },
  init_options = {
    provideFormatter = false,
  },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://www.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig.json" },
          url = "https://www.schemastore.org/tsconfig.json",
        },
      },
    },
  },
}
