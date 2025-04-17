local capabilities = require("blink.cmp").get_lsp_capabilities()

--- @type vim.lsp.Config
return {
	capabilities = capabilities,
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_markers = {
		"tsconfig.json",
		"jsconfig.json",
		"package.json",
		".git",
	},
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = {
			preferences = {
				importModuleSpecifier = "non-relative",
				importModuleSpecifierEnding = "js",
			},
			updateImportsOnFileMove = {
				enabled = "always",
			},
			suggest = {
				completeFunctionCalls = true,
			},
		},
	},
}
