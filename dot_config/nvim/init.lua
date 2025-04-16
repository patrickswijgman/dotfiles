vim.loader.enable()

require("config.options")
require("config.keymaps")
require("config.filetypes")
require("config.autocmds")

require("core.lsp")
require("core.statusline")
require("core.format")
require("core.find")
require("core.grep")
require("core.fs")

require("plugins.files")
