local group = vim.api.nvim_create_augroup("UserPluginFileSystem", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		vim.fn.mkdir(vim.fn.fnamemodify(args.file, ":p:h"), "p")
	end,
	group = group,
	desc = "Create intermediate directories before writing the buffer",
})
