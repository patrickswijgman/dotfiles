local function command(args)
	local pattern = args.fargs[1]
	vim.cmd(string.format("silent grep! %s | botright copen", pattern))
end

vim.api.nvim_create_user_command("Grep", command, {
	nargs = 1,
	desc = "Grep content",
})
