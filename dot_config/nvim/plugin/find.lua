local function command(args)
	vim.cmd("find " .. args.fargs[1])
end

local function complete(ArgLead)
	local files = vim.system({ "rg", "--files", "--hidden", "--glob=!**/.git/*" }):wait()
	local filtered = vim.system({ "rg", "--smart-case", ArgLead }, { stdin = files.stdout }):wait()
	local sorted = vim.system({ "sort" }, { stdin = filtered.stdout }):wait()
	return vim.split(sorted.stdout, "\n", { trimempty = true })
end

vim.api.nvim_create_user_command("Find", command, {
	complete = complete,
	nargs = 1,
	desc = "Find file using ripgrep",
})
