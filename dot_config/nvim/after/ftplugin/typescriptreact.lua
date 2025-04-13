local fmt = require("lib.fmt")

local group = vim.api.nvim_create_augroup("UserFileTypePluginTypescriptreact", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		fmt.format(args.buf, { "prettierd", ".tsx" })
	end,
	group = group,
	desc = "Format typescriptreact file on save",
})
