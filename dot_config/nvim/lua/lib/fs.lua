local M = {}

local function delete_buffers(pattern)
	local bufs = vim.api.nvim_list_bufs()
	local match = string.format("^%s", vim.pesc(pattern))

	vim.print(bufs, match)

	for _, buf in ipairs(bufs) do
		local path = vim.api.nvim_buf_get_name(buf)

		if string.match(path, match) then
			vim.print("DELETE", buf)
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

function M.dirname(path, relative)
	return vim.fn.fnamemodify(path, relative and ":h" or ":p:h")
end

function M.is_dir(path)
	return vim.fn.isdirectory(path) == 1
end

function M.is_file(path)
	return vim.fn.isdirectory(path) == 0
end

function M.list_files(pattern, include_dirs)
	local cmd = { "fd", "--hidden", "--exclude=.git", "--type=file" }

	if include_dirs then
		table.insert(cmd, "--type=directory")
	end

	local result = vim.system(cmd):wait()

	if pattern and pattern ~= "" then
		result = vim.system({ "fzf", "--filter", pattern }, { stdin = result.stdout }):wait()
	end

	if result.stdout then
		return vim.split(result.stdout, "\n", { trimempty = true })
	end

	return {}
end

function M.ensure_dir(path)
	local dir = M.dirname(path)
	vim.system({ "mkdir", "-p", dir }):wait()
end

function M.new(path)
	M.ensure_dir(path)
	if M.is_file(path) then
		vim.system({ "touch", path }):wait()
	end
end

function M.move(src, dest)
	M.ensure_dir(dest)
	delete_buffers(src)
	vim.system({ "mv", src, dest }):wait()
end

function M.remove(path)
	delete_buffers(path)
	vim.system({ "rm", "-r", path }):wait()
end

return M
