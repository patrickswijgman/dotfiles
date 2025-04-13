local M = {}

function M.leftpad(str, char, count)
	return string.format("%s%s", string.rep(char, count), str)
end

return M
