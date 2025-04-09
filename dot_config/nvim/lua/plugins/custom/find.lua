vim.o.path = ".,**"

vim.api.nvim_create_user_command("Find", function(args)
	vim.cmd(string.format("find %s", args.fargs[1]))
end, {
	nargs = 1,
	complete = function(ArgLead)
		local output = vim.fn.systemlist(string.format("rg --files --hidden --glob='!**/.git/*' | rg --smart-case %s", ArgLead ~= "" and ArgLead or "."))

		if vim.v.shell_error ~= 0 then
			vim.notify(table.concat(output, "\n"), vim.log.levels.ERROR)
			return {}
		end

		return output
	end,
})

vim.keymap.set("n", "<leader>f", ":Find ", { desc = "Find file" })
