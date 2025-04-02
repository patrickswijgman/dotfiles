local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "checkhealth,qf,spectre",
	command = "set nospell",
	group = group,
	desc = "Disable spelling for certain file types",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = group,
	desc = "Highlight on yank",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		vim.fn.mkdir(vim.fn.fnamemodify(args.file, ":p:h"), "p")
	end,
	group = group,
	desc = "Create missing intermediate directories before writing the file",
})
