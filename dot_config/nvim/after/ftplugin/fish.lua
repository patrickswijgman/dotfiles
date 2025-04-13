local format = require("lib.format")

local group = vim.api.nvim_create_augroup("UserFileTypePluginFish", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		format(args.buf)
	end,
	group = group,
	desc = "Format fish file on save",
})
