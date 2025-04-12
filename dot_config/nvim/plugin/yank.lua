local group = vim.api.nvim_create_augroup("UserPluginYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	group = group,
	desc = "Highlight on yank",
})
