local M = {}

function M.ensure_dir(path)
	vim.fn.mkdir(vim.fn.fnamemodify(path, ":p:h"), "p")
end

return M
