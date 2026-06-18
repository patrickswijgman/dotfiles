---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "package-lock.json",
    "yarn.lock",
    "pnpm-lock.yaml",
    "bun.lockb",
    "bun.lock",
    ".git",
  },
  init_options = {
    hostInfo = "neovim",
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
