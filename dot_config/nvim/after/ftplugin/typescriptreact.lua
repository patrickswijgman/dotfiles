local format = require("lib.format")

local group = vim.api.nvim_create_augroup("UserFileTypePluginTypescriptreact", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		format(args.buf, { "prettierd", ".tsx" })
	end,
	group = group,
	desc = "Format typescriptreact file on save",
})
