local fs = require("lib.fs")
local str = require("lib.str")

local win = -1
local win_prev = -1
local buf = -1
local ns = vim.api.nvim_create_namespace("files_highlight")
local query = ""

local function focus(pattern)
	if pattern ~= "" then
		vim.fn.search(vim.fn.escape(pattern, "/"), "w")
	end
end

local function reload()
	local files = vim.system({ "fd", "--hidden", "--exclude=.git" }, { text = true }):wait()
	local filtered = vim.system({ "rg", "--smart-case", query }, { text = true, stdin = files.stdout }):wait()

	if filtered.code ~= 0 then
		return
	end

	local lines = vim.split(filtered.stdout, "\n", { plain = true, trimempty = true })

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	for i, line in ipairs(lines) do
		local _, indent = string.gsub(line, "/", "")

		if fs.is_dir(line) then
			vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
				end_line = i,
				hl_group = "Directory",
				virt_text = { { str.leftpad("󰉋 ", "  ", indent), "Directory" } },
				virt_text_pos = "inline",
			})
		else
			vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
				end_line = i,
				virt_text = { { str.leftpad("󰈤 ", "  ", indent + 1) } },
				virt_text_pos = "inline",
			})
		end
	end
end

local function filter()
	local path = vim.api.nvim_get_current_line()

	vim.ui.input({ prompt = "Filter > " }, function(input)
		if input then
			if input ~= "" then
				query = input
			else
				query = ""
			end
		end

		reload()
		focus(path)
	end)
end

local function clear()
	local path = vim.api.nvim_get_current_line()
	query = ""
	reload()
	focus(path)
end

local function add()
	local parent = fs.dirname(vim.api.nvim_get_current_line())
	local default = string.format("%s/", parent)

	vim.ui.input({ prompt = "New file/directory > ", default = default }, function(input)
		if input and input ~= "" then
			fs.create(input)
			reload()
			focus(input)
		end
	end)
end

local function move()
	local src = vim.api.nvim_get_current_line()

	vim.ui.input({ prompt = "Move > ", default = src }, function(input)
		if input and input ~= "" then
			fs.move(src, input)
			reload()
			focus(input)
		end
	end)
end

local function delete()
	local path = vim.api.nvim_get_current_line()
	local prompt = string.format("Delete %s? (y/n) ", path)

	vim.ui.input({ prompt = prompt }, function(input)
		if input == "y" then
			fs.remove(path)
			reload()
		end
	end)
end

local function open()
	local path = vim.api.nvim_get_current_line()

	if fs.is_dir(path) then
		return
	end

	vim.api.nvim_buf_delete(buf, {})
	vim.api.nvim_set_current_win(win_prev)
	vim.cmd(string.format("find %s", path))
end

local function quit()
	vim.api.nvim_buf_delete(buf, {})
end

local function command()
	local current_file = vim.fn.expand("%")

	win_prev = vim.api.nvim_get_current_win()
	buf = vim.api.nvim_create_buf(true, true)
	query = ""

	reload()

	local max_w = vim.o.columns
	local max_h = vim.o.lines
	local w = math.max(100, math.floor(max_w * 0.5))
	local h = math.max(10, math.floor(max_h * 0.8))
	local x = (max_w - w) / 2
	local y = (max_h - h) / 2

	win = vim.api.nvim_open_win(buf, true, {
		title = " Files ",
		col = x,
		row = y,
		width = w,
		height = h,
		relative = "editor",
	})

	vim.wo[win].spell = false

	focus(current_file)

	vim.keymap.set("n", "o", open, { buffer = buf, desc = "Open file" })
	vim.keymap.set("n", "<cr>", open, { buffer = buf, desc = "Open file" })
	vim.keymap.set("n", "a", add, { buffer = buf, desc = "Create new file or directory" })
	vim.keymap.set("n", "m", move, { buffer = buf, desc = "Move file or directory" })
	vim.keymap.set("n", "r", move, { buffer = buf, desc = "Move file or directory" })
	vim.keymap.set("n", "d", delete, { buffer = buf, desc = "Delete file or directory" })
	vim.keymap.set("n", "f", filter, { buffer = buf, desc = "Filter" })
	vim.keymap.set("n", "F", clear, { buffer = buf, desc = "Clear filter" })
	vim.keymap.set("n", "R", reload, { buffer = buf, desc = "Reload" })
	vim.keymap.set("n", "q", quit, { buffer = buf, desc = "Close" })
	vim.keymap.set("n", "<esc>", quit, { buffer = buf, desc = "Close" })
end

vim.api.nvim_create_user_command("Files", command, { desc = "Manage files" })
