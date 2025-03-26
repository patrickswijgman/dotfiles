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

lspconfig.html.setup({
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
})

lspconfig.gopls.setup({
	capabilities = capabilities,
})

lspconfig.golangci_lint_ls.setup({
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
})

lspconfig.pyright.setup({
	capabilities = capabilities,
	settings = {
		python = {
			pythonPath = ".venv/bin/python",
		},
	},
})

lspconfig.ruff.setup({
	capabilities = capabilities,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
})

lspconfig.yamlls.setup({
	capabilities = capabilities,
})

lspconfig.taplo.setup({
	capabilities = capabilities,
})

local group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end

		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP rename" })
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP code action" })
		vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP show function signature" })

		-- Disable semantic tokens in favor of Treesitter.
		client.server_capabilities.semanticTokensProvider = nil
	end,
	group = group,
	desc = "LSP on attach",
})
