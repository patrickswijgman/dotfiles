local fs = require("lib.fs")

local group = vim.api.nvim_create_augroup("UserPluginFileSystem", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		fs.ensure_dir(args.file)
	end,
	group = group,
	desc = "Create intermediate directories before writing the buffer",
})
