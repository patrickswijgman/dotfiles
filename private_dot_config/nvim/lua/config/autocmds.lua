local group = vim.api.nvim_create_augroup("Config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "checkhealth", "qf" },
	command = "set nospell",
	group = group,
	desc = "Disable spelling for certain file types",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	group = group,
	desc = "Highlight on yank",
})
