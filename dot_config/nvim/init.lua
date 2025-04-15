require("config.options")
require("config.keymaps")
require("config.filetypes")
require("config.autocmds")
require("config.lsp")

require("plugins.files")
require("plugins.grep")
require("plugins.statusline")

require("plugins.format").setup({
	lua = { "stylua", "-" },
	nix = {},
	fish = {},
	typescript = { "prettierd", ".ts" },
	typescriptreact = { "prettierd", ".tsx" },
})
