local M = {}

local _query = nil
local _buf = 0
local _win = 0

function M.set_query(query)
	_query = query
end

function M.get_query()
	return _query
end

function M.reset_query()
	_query = nil
end

function M.set_buf(buf)
	_buf = buf
end

function M.get_buf()
	return _buf
end

function M.set_win(win)
	_win = win
end

function M.get_win()
	return _win
end

function M.is_current_win()
	return vim.api.nvim_win_is_valid(_win) and _win == vim.api.nvim_get_current_win()
end

function M.is_win_open()
	return _win > 0
end

function M.reset_win()
	_win = 0
end

return M
