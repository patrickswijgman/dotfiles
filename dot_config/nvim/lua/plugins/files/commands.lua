local core = require("plugins.files.core")
local state = require("plugins.files.state")

local function command()
	if state.is_win_open() then
		return
	end

	local current_file = vim.api.nvim_buf_get_name(0)

	local buf = state.get_buf()
	local max_w = vim.o.columns
	local max_h = vim.o.lines
	local w = math.max(100, math.floor(max_w * 0.5))
	local h = math.max(10, math.floor(max_h * 0.8))
	local x = (max_w - w) / 2
	local y = (max_h - h) / 4

	local win = vim.api.nvim_open_win(buf, true, {
		title = " Files ",
		col = x,
		row = y,
		width = w,
		height = h,
		relative = "editor",
	})

	vim.wo[win].spell = false

	state.set_win(win)

	core.reload()
	core.reveal(current_file)
end

return function()
	vim.api.nvim_create_user_command("Files", command, { desc = "Manage files" })
end
