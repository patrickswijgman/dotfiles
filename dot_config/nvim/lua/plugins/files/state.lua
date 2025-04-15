local M = {}

local _query = nil
local _buf = 0
local _win = 0
local _win_prev = 0

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

function M.is_current_buffer()
	return _buf == vim.api.nvim_get_current_buf()
end

function M.set_win(win, win_prev)
	_win = win
	_win_prev = win_prev
end

function M.get_win()
	return _win
end

function M.get_previous_win()
	return _win_prev
end

function M.is_window_open()
	return _win > 0
end

function M.reset_handles()
	_win = 0
	_win_prev = 0
	_buf = 0
end

return M
