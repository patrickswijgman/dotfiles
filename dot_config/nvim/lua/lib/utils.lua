local M = {}

function M.esc(pattern)
	return vim.pesc(vim.fn.escape(pattern, "/"))
end

function M.seek(pattern)
	if pattern and pattern ~= "" then
		vim.fn.search(vim.fn.escape(pattern, "/"), "w")
	end
end

function M.match(pattern)
	if pattern and pattern ~= "" then
		vim.cmd(string.format("match Visual /\\c%s/", M.esc(pattern)))
	else
		vim.cmd("match none")
	end
end

return M
