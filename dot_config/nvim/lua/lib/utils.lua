local M = {}

function M.get_common_chars()
	local chars = {}
	for i = 32, 126 do
		table.insert(chars, string.char(i))
	end
	return chars
end

return M

