require("plugins.files.autocmds")

local lib = require("lib")
local state = require("plugins.files.state")

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

local function reload()
	local buf = state.get_buf()
	local win = state.get_win()
	local query = state.get_query()
	local lines = list_files(query)

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	local namespace = vim.api.nvim_create_namespace("files_highlight")
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
				virt_text = { { "* " } },
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

local function filter()
	local path = vim.api.nvim_get_current_line()

	vim.ui.input({ prompt = "Filter: ", completion = "file" }, function(input)
		if input and input ~= "" then
			state.set_query(input)
			reload()
			lib.utils.seek(path)
		end
	end)
end

local function clear()
	local path = vim.api.nvim_get_current_line()
	state.reset_query()
	reload()
	lib.utils.seek(path)
end

local function add()
	local parent = lib.fs.dirname(vim.api.nvim_get_current_line(), true)
	local default = string.format("%s/", parent)

	vim.ui.input({ prompt = "New file/directory: ", default = default }, function(input)
		if input and input ~= "" then
			lib.fs.create(input)
			reload()
			lib.utils.seek(input)
		end
	end)
end

local function move()
	local src = vim.api.nvim_get_current_line()
	local prompt = string.format("Move: %s -> ", src)

	vim.ui.input({ prompt = prompt, default = src, completion = "dir" }, function(input)
		if input and input ~= "" then
			lib.fs.move(src, input)
			reload()
			lib.utils.seek(input)
		end
	end)
end

local function delete()
	local path = vim.api.nvim_get_current_line()
	local prompt = string.format("Delete: %s (y/n) ", path)

	vim.ui.input({ prompt = prompt }, function(input)
		if input == "y" then
			lib.fs.remove(path)
			reload()
		end
	end)
end

local function open()
	local path = vim.api.nvim_get_current_line()

	if lib.fs.is_dir(path) then
		return
	end

	local win_prev = state.get_previous_win()
	vim.api.nvim_set_current_win(win_prev)

	vim.cmd(string.format("find %s", path))
end

local function command()
	if state.is_window_open() then
		return
	end

	local current_file = vim.fn.expand("%")

	local buf = vim.api.nvim_create_buf(true, true)

	local max_w = vim.o.columns
	local max_h = vim.o.lines
	local w = math.max(100, math.floor(max_w * 0.5))
	local h = math.max(10, math.floor(max_h * 0.8))
	local x = (max_w - w) / 2
	local y = (max_h - h) / 2

	local win_prev = vim.api.nvim_get_current_win()
	local win = vim.api.nvim_open_win(buf, true, {
		title = " Files ",
		col = x,
		row = y,
		width = w,
		height = h,
		relative = "editor",
	})

	vim.wo[win].spell = false

	state.set_buf(buf)
	state.set_win(win, win_prev)

	reload()
	lib.utils.seek(current_file)

	vim.keymap.set("n", "o", open, { buffer = buf, desc = "Open file" })
	vim.keymap.set("n", "<cr>", open, { buffer = buf, desc = "Open file" })
	vim.keymap.set("n", "a", add, { buffer = buf, desc = "Create new file or directory" })
	vim.keymap.set("n", "m", move, { buffer = buf, desc = "Move file or directory" })
	vim.keymap.set("n", "r", move, { buffer = buf, desc = "Move file or directory" })
	vim.keymap.set("n", "d", delete, { buffer = buf, desc = "Delete file or directory" })
	vim.keymap.set("n", "f", filter, { buffer = buf, desc = "Filter" })
	vim.keymap.set("n", "F", clear, { buffer = buf, desc = "Clear filter" })
	vim.keymap.set("n", "R", reload, { buffer = buf, desc = "Reload" })
	vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = buf, desc = "Close" })
	vim.keymap.set("n", "<esc>", "<cmd>quit<cr>", { buffer = buf, desc = "Close" })
end

vim.api.nvim_create_user_command("Files", command, { desc = "Manage files" })
