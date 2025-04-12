local function command(args)
	local pattern = args.fargs[1]
	vim.cmd("silent grep! " .. pattern)
	vim.cmd("botright copen")
	vim.cmd("match Visual /\\c" .. vim.pesc(pattern) .. "/")
end

vim.api.nvim_create_user_command("Grep", command, {
	nargs = 1,
	desc = "Grep content with ripgrep",
})
