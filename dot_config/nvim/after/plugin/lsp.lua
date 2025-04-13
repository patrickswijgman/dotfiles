vim.lsp.enable("lua_ls", true)
vim.lsp.enable("nixd", true)
vim.lsp.enable("fish_lsp", true)
vim.lsp.enable("vtsls", true)
vim.lsp.enable("eslint", true)

local group = vim.api.nvim_create_augroup("UserLsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

		-- Disable semantic tokens in favor of Treesitter.
		client.server_capabilities.semanticTokensProvider = nil
	end,
	group = group,
	desc = "LSP on attach",
})

vim.diagnostic.config({
	virtual_lines = { current_line = true },
})
