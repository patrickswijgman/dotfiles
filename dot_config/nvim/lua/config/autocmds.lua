local group = vim.api.nvim_create_augroup("Config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "checkhealth", "qf" },
	command = "setlocal nospell",
	group = group,
	desc = "Disable spelling for certain file types",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	group = group,
	desc = "Highlight on yank",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		vim.fn.mkdir(vim.fn.fnamemodify(args.file, ":h:p"), "p")
	end,
	group = group,
	desc = "Create intermediate directories before writing the buffer",
})
