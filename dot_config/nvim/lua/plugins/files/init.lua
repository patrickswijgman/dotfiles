local setup_commands = require("plugins.files.commands")
local setup_autocmds = require("plugins.files.autocmds")
local setup_keymaps = require("plugins.files.keymaps")
local setup_buffer = require("plugins.files.buffer")

local M = {}

function M.setup()
	setup_buffer()
	setup_commands()
	setup_autocmds()
	setup_keymaps()
end

return M
