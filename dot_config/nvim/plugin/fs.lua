local utils = require("lib.utils")

local group = vim.api.nvim_create_augroup("UserPluginFileSystem", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		utils.ensure_dir(args.file)
	end,
	group = group,
	desc = "Create intermediate directories before writing the buffer",
})
