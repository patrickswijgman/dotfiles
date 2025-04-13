local utils = require("lib.utils")

local win = 0
local win_prev = 0
local buf = 0

local function focus(pattern)
	vim.fn.search(vim.fn.escape(pattern, "/"), "w")
end

local function reload()
	local obj = vim.system({ "fd" }, { text = true }):wait()
	local files = vim.split(obj.stdout, "\n", { plain = true, trimempty = true })

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)
	vim.bo[buf].modifiable = false
end

local function open()
	local file = vim.api.nvim_get_current_line()
	vim.api.nvim_win_close(win, true)
	vim.api.nvim_set_current_win(win_prev)
	vim.cmd(string.format("find %s", file))
end

local function add()
	local parent = vim.fn.fnamemodify(vim.api.nvim_get_current_line(), ":p:h")
	local default = string.format("%s/", parent)

	vim.ui.input({ prompt = "New file/directory > ", default = default }, function(path)
		if path and path ~= "" then
			utils.ensure_dir(path)

			if not vim.endswith(path, "/") then
				local file = io.open(path, "w")
				if file then
					file:close()
				end
			end

			reload()
			focus(path)
		end
	end)
end

local function move()
	local oldname = vim.api.nvim_get_current_line()

	vim.ui.input({ prompt = "Move > ", default = oldname }, function(newname)
		if newname and newname ~= "" then
			utils.ensure_dir(newname)
			os.rename(oldname, newname)
			reload()
			focus(newname)
		end
	end)
end

local function delete()
	local path = vim.api.nvim_get_current_line()
	local prompt = string.format("Delete %s? (y/n) ", path)

	vim.ui.input({ prompt = prompt }, function(input)
		if input == "y" then
			os.remove(path)
			reload()
		end
	end)
end

local function quit()
	vim.api.nvim_buf_delete(buf, { force = true })
end

local function command()
	local current_file = vim.fn.expand("%")

	win_prev = vim.api.nvim_get_current_win()
	buf = vim.api.nvim_create_buf(true, true)

	reload()

	local max_w = vim.o.columns
	local max_h = vim.o.lines
	local w = math.max(100, math.floor(max_w * 0.9))
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

	if current_file ~= "" then
		focus(current_file)
	end

	vim.keymap.set("n", "<cr>", open, { buffer = buf, desc = "Open file" })
	vim.keymap.set("n", "a", add, { buffer = buf, desc = "Create new file or directory" })
	vim.keymap.set("n", "m", move, { buffer = buf, desc = "Move file or directory" })
	vim.keymap.set("n", "d", delete, { buffer = buf, desc = "Delete file or directory" })
	vim.keymap.set("n", "R", reload, { buffer = buf, desc = "Reload" })
	vim.keymap.set("n", "q", quit, { buffer = buf, desc = "Close" })
end

vim.api.nvim_create_user_command("Files", command, { desc = "Manage files" })
