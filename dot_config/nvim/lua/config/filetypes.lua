vim.filetype.add({
	pattern = {
		[".env"] = "properties",
		[".env.*"] = "properties",
		[".env.*.local"] = "properties",
		[".*ignore"] = "gitignore",
		[".*.toml.tmpl"] = "toml",
	},
})
