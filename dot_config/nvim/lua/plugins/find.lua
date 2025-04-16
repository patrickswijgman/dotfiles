local fs = require("lib.fs")

local function command(args)
	local path = args.fargs[1]
	vim.cmd.find(path)
end

local function complete(arg)
	return fs.list_files(arg, false)
end

vim.api.nvim_create_user_command("Find", command, {
	nargs = 1,
	complete = complete,
	desc = "Grep content",
})

