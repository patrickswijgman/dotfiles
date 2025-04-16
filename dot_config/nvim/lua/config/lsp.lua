local utils = require("lib.utils")

vim.lsp.enable("lua_ls", true)
vim.lsp.enable("nixd", true)
vim.lsp.enable("fish_lsp", true)
vim.lsp.enable("vtsls", true)
vim.lsp.enable("eslint", true)

local chars = utils.get_common_chars()
local group = vim.api.nvim_create_augroup("ConfigLsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Trigger auto completion on every key press.
		client.server_capabilities.completionProvider.triggerCharacters = chars
		vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

		-- Disable semantic tokens in favor of Treesitter.
		client.server_capabilities.semanticTokensProvider = nil
	end,
	group = group,
	desc = "LSP on attach",
})

vim.diagnostic.config({
	virtual_text = { current_line = true },
})

vim.keymap.set("i", "<c-space>", vim.lsp.completion.get, { desc = "Get LSP completion" })

