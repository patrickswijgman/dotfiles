local group = vim.api.nvim_create_augroup("ConfigTreesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
	group = group,
	desc = "Try to start treesitter for all file types",
})
