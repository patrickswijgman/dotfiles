local format = require("lib.format")

local group = vim.api.nvim_create_augroup("UserFileTypePluginLua", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		format(args.buf, { "stylua", "-" })
	end,
	group = group,
	desc = "Format lua file on save",
})
