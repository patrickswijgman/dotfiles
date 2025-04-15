require("config.options")
require("config.keymaps")
require("config.filetypes")
require("config.autocmds")
require("config.lsp")
require("config.treesitter")

require("plugins.grep").setup()
require("plugins.files").setup()
require("plugins.format").setup({
	lua = { "stylua", "-" },
	nix = {},
	fish = {},
	typescript = { "prettierd", ".ts" },
	typescriptreact = { "prettierd", ".tsx" },
	javascript = { "prettierd", ".js" },
	javascriptreact = { "prettierd", ".jsx" },
	html = { "prettierd", ".html" },
	css = { "prettierd", ".css" },
	json = { "prettierd", ".json" },
	jsonc = { "prettierd", ".jsonc" },
	yaml = { "prettierd", ".yaml" },
	markdown = { "prettierd", ".md" },
})
require("plugins.statusline").setup()
