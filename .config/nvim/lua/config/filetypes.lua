vim.filetype.add({
	pattern = {
		[".*/config"] = { "config", { priority = 10 } },
	},
})
