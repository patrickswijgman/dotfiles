vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob='!**/.git/*'"

vim.api.nvim_create_user_command("Grep", function(args)
	local pattern = args.fargs[1]
	vim.cmd(string.format("silent grep! %s | botright copen | match search /%s/", pattern, vim.pesc(pattern)))
end, {
	nargs = 1,
})

vim.keymap.set("n", "<leader>/", ":Grep ", { desc = "Grep content" })
