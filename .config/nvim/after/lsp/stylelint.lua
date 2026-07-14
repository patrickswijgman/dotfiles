---@type vim.lsp.Config
return {
  cmd = { "stylelint-lsp", "--stdio" },
  filetypes = {
    "astro",
    "css",
    "html",
    "less",
    "scss",
    "vue",
  },
  root_markers = {
    ".stylelintrc",
    ".stylelintrc.mjs",
    ".stylelintrc.cjs",
    ".stylelintrc.js",
    ".stylelintrc.json",
    ".stylelintrc.yaml",
    ".stylelintrc.yml",
    "stylelint.config.mjs",
    "stylelint.config.cjs",
    "stylelint.config.js",
    ".git",
  },
}
