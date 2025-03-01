local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.nixd.setup({
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files.
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
})

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = function(client)
		-- Disable semantic tokens in favor of Treesitter.
		client.server_capabilities.semanticTokensProvider = nil
	end,
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			importModuleSpecifierEnding = "js",
		},
	},
})

lspconfig.eslint.setup({
	capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
})

lspconfig.taplo.setup({
	capabilities = capabilities,
})

lspconfig.yamlls.setup({
	capabilities = capabilities,
})

local lsp_group = vim.api.nvim_create_augroup("UserConfigLsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP show function signature" })
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "LSP show diagnostic" })
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP rename" })
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP code action" })
	end,
	group = lsp_group,
	desc = "LSP on attach",
})

require("lsp_lines").setup({})

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_text = false,
})

require("fidget").setup({})
