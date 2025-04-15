local M = {}

function M.highlight(pattern, hl_group)
	vim.fn.clearmatches()
	if pattern and pattern ~= "" then
		vim.fn.matchadd(hl_group or "Visual", string.format("\\v\\c%s", pattern))
	end
end

return M
