vim.api.nvim_create_autocmd("FileType", {
	pattern = { "checkhealth", "qf" },
	command = "set nospell",
	desc = "Disable spelling for certain file types",
})
