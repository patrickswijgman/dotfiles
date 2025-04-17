local capabilities = require("blink.cmp").get_lsp_capabilities()

--- @type vim.lsp.Config
return {
	capabilities = capabilities,
	cmd = { "fish-lsp", "start" },
	cmd_env = {
		fish_lsp_show_client_popups = false,
	},
	filetypes = { "fish" },
	root_markers = { ".git" },
}
