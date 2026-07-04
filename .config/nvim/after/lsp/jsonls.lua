---@type vim.lsp.Config
return {
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
