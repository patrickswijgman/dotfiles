local core = require("plugins.files.core")
local state = require("plugins.files.state")
local create_window = require("plugins.files.window")

local function command()
	if state.is_win_open() then
		return
	end

	local current_file = vim.api.nvim_buf_get_name(0)

	create_window()

	core.reload()
	core.reveal(current_file)
end

vim.api.nvim_create_user_command("Files", command, { desc = "Manage files" })

