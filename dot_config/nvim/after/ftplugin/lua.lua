local fmt = require("lib.fmt")

local group = vim.api.nvim_create_augroup("UserFileTypePluginLua", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		fmt.format(args.buf, { "stylua", "-" })
	end,
	group = group,
	desc = "Format lua file on save",
})
