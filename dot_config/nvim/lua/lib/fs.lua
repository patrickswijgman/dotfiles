local M = {}

function M.dirname(path, relative)
	return vim.fn.fnamemodify(path, relative and ":h" or ":p:h")
end

function M.ensure_dir(path)
	local dir = M.dirname(path)
	vim.system({ "mkdir", "-p", dir }):wait()
end

function M.move(src, dest)
	M.ensure_dir(dest)
	vim.system({ "mv", src, dest }):wait()
end

function M.create(path)
	M.ensure_dir(path)
	if M.is_file(path) then
		vim.system({ "touch", path }):wait()
	end
end

function M.remove(path)
	vim.system({ "rm", "-r", path }):wait()
end

function M.is_dir(path)
	return vim.endswith(path, "/")
end

function M.is_file(path)
	return not M.is_dir(path)
end

function M.list_files(pattern)
	local result = vim.system({ "fd", "--hidden", "--exclude=.git" }, { text = true }):wait()
	if pattern then
		result = vim.system({ "rg", "--smart-case", "--fixed-strings", pattern }, { text = true, stdin = result.stdout }):wait()
	end
	return vim.split(result.stdout or "", "\n", { plain = true, trimempty = true })
end

return M
