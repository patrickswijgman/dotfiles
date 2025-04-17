vim.lsp.enable("eslint")
vim.lsp.enable("fish_lsp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("nixd")
vim.lsp.enable("vtsls")

local group = vim.api.nvim_create_augroup("Lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Disable semantic tokens in favor of Treesitter.
		client.server_capabilities.semanticTokensProvider = nil
	end,
	group = group,
	desc = "LSP on attach",
})

vim.diagnostic.config({
	virtual_text = { current_line = true },
})
