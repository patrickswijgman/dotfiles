--- @type vim.lsp.Config
return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = {
		"html",
		"templ",
	},
	root_markers = {
		"package.json",
		".git",
	},
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
	},
}
