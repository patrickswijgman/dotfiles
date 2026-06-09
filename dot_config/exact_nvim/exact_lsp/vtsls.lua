---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  init_options = {
    hostInfo = "neovim",
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "package-lock.json",
    ".git",
  },
  settings = {
    javascript = {
      preferences = {
        importModuleSpecifier = "non-relative",
        importModuleSpecifierEnding = "js",
      },
    },
    typescript = {
      preferences = {
        importModuleSpecifier = "non-relative",
        importModuleSpecifierEnding = "js",
      },
    },
  },
}
