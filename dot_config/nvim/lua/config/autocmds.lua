local fs = require("lib.fs")

local group = vim.api.nvim_create_augroup("Config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
	group = group,
	desc = "Try to start treesitter for all file types",
})

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
		fs.ensure_dir(args.file)
	end,
	group = group,
	desc = "Create intermediate directories before writing the buffer",
})

