local setup_commands = require("plugins.files.commands")
local setup_autocmds = require("plugins.files.autocmds")
local setup_keymaps = require("plugins.files.keymaps")
local state = require("plugins.files.state")

local M = {}

function M.setup()
	local buf = vim.api.nvim_create_buf(false, true)

	state.set_buf(buf)

	setup_commands()
	setup_autocmds()
	setup_keymaps(buf)
end

return M
