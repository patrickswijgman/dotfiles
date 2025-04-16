local fs = require("lib.fs")

local function new()
	local current_file = vim.api.nvim_buf_get_name(0)
	local dir = fs.dirname(current_file, true)

	vim.ui.input({ prompt = "New: ", default = dir, completion = "dir" }, function(input)
		if input and input ~= "" then
			fs.new(input)
			if fs.is_file(input) then
				vim.cmd.edit(input)
			end
		end
	end)
end

local function move()
	local current_file = vim.api.nvim_buf_get_name(0)

	vim.ui.input({ prompt = "Move: ", default = current_file, completion = "dir" }, function(input)
		if input and input ~= "" then
			if fs.is_file(input) then
				fs.move(current_file, input)
				vim.cmd.edit(input)
			end
		end
	end)
end

local function remove()
	local current_file = vim.api.nvim_buf_get_name(0)

	vim.ui.input({ prompt = "Remove: ", default = current_file }, function(input)
		if input and input ~= "" then
			fs.remove(input)
		end
	end)
end

vim.api.nvim_create_user_command("FileSystemNew", new, { desc = "New file/directory" })
vim.api.nvim_create_user_command("FileSystemMove", move, { desc = "Move current file" })
vim.api.nvim_create_user_command("FileSystemRemove", remove, { desc = "Remove file/directory" })

