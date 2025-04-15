local lib = require("lib")
local state = require("plugins.files.state")

local M = {}

local function list_files(pattern)
	local files = vim.system({ "fd", "--hidden", "--exclude=.git" }, { text = true }):wait().stdout

	if pattern then
		files = vim.system({ "rg", "--smart-case", pattern }, { text = true, stdin = files }):wait().stdout
	end

	if not files then
		return {}
	end

	return vim.split(files, "\n", { plain = true, trimempty = true })
end

function M.reload()
	local buf = state.get_buf()
	local win = state.get_win()
	local query = state.get_query()
	local lines = list_files(query)

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	local namespace = vim.api.nvim_create_namespace("plugin_files_highlight")
	vim.api.nvim_buf_clear_namespace(buf, namespace, 0, -1)

	for i, line in ipairs(lines) do
		if lib.fs.is_dir(line) then
			vim.api.nvim_buf_set_extmark(buf, namespace, i - 1, 0, {
				end_line = i,
				hl_group = "Directory",
				virt_text = { { "󰉋 ", "Directory" } },
				virt_text_pos = "inline",
			})
		else
			vim.api.nvim_buf_set_extmark(buf, namespace, i - 1, 0, {
				end_line = i,
				virt_text = { { "󰈤 " } },
				virt_text_pos = "inline",
			})
		end
	end

	vim.api.nvim_win_set_config(win, {
		footer = query and string.format("[FILTER: %s]", query) or "",
		footer_pos = "right",
	})

	lib.utils.match(query)
end

function M.filter()
	local path = vim.api.nvim_get_current_line()

	vim.ui.input({ prompt = "Filter: ", completion = "file" }, function(input)
		if input and input ~= "" then
			state.set_query(input)
			M.reload()
			lib.utils.seek(path)
		end
	end)
end

function M.clear()
	local path = vim.api.nvim_get_current_line()
	state.reset_query()
	M.reload()
	lib.utils.seek(path)
end

function M.add()
	local parent = lib.fs.dirname(vim.api.nvim_get_current_line(), true)
	local default = string.format("%s/", parent)

	vim.ui.input({ prompt = "New file/directory: ", default = default }, function(input)
		if input and input ~= "" then
			lib.fs.create(input)
			M.reload()
			lib.utils.seek(input)
		end
	end)
end

function M.move()
	local src = vim.api.nvim_get_current_line()
	local prompt = string.format("Move: %s -> ", src)

	vim.ui.input({ prompt = prompt, default = src, completion = "dir" }, function(input)
		if input and input ~= "" then
			lib.fs.move(src, input)
			M.reload()
			lib.utils.seek(input)
		end
	end)
end

function M.delete()
	local path = vim.api.nvim_get_current_line()
	local prompt = string.format("Delete: %s (y/n) ", path)

	vim.ui.input({ prompt = prompt }, function(input)
		if input == "y" then
			lib.fs.remove(path)
			M.reload()
		end
	end)
end

function M.close_window()
	vim.api.nvim_win_close(state.get_win(), true)
	state.reset_win()
end

function M.open()
	local path = vim.api.nvim_get_current_line()

	if lib.fs.is_dir(path) then
		return
	end

	M.close_window()

	vim.cmd(string.format("edit %s", path))
end

return M
