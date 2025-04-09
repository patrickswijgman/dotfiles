require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.filetypes")
require("config.colorscheme")

require("plugins.custom.find")
require("plugins.custom.grep")
require("plugins.custom.statusline")

-- require("plugins.cmp")
require("plugins.conform")
require("plugins.lsp")
-- require("plugins.lualine")
require("plugins.nvim-spectre")
require("plugins.nvim-surround")
require("plugins.nvim-tree")
require("plugins.spider")
-- require("plugins.telescope")
require("plugins.treesitter")
require("plugins.zen-mode")

-- Make sure all plugins are loaded before a previous session is restored.
require("plugins.auto-session")
