vim.filetype.add({
	extension = {
		postcss = "css",
	},
	pattern = {
		[".env*"] = "properties",
		[".*ignore"] = "gitignore",
	},
})
