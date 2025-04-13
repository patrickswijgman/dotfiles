local format = require("lib.format")

local group = vim.api.nvim_create_augroup("UserFileTypePluginTypescript", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		format(args.buf, { "prettierd", ".ts" })
	end,
	group = group,
	desc = "Format typescript file on save",
})
