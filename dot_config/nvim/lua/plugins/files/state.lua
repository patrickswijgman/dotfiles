local M = {}

local query = nil
local buf = 0
local win = 0

function M.set_query(new_query)
	query = new_query
end

function M.get_query()
	return query
end

function M.reset_query()
	query = nil
end

function M.set_buf(new_buf)
	buf = new_buf
end

function M.get_buf()
	return buf
end

function M.set_win(new_win)
	win = new_win
end

function M.get_win()
	return win
end

function M.is_current_win()
	return vim.api.nvim_win_is_valid(win) and win == vim.api.nvim_get_current_win()
end

function M.is_win_open()
	return win > 0
end

function M.reset_win()
	win = 0
end

return M
