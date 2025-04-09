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
				-- Tell the language server which version of Lua you're using.
				-- (Most likely LuaJIT in the case of Neovim.)
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

lspconfig.fish_lsp.setup({
	capabilities = capabilities,
})

lspconfig.vtsls.setup({
	capabilities = capabilities,
	settings = {
		typescript = {
			preferences = {
				importModuleSpecifier = "non-relative",
				importModuleSpecifierEnding = "js",
			},
		},
	},
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = function(_, bufnr)
		local group = vim.api.nvim_create_augroup("UserLspEslint", { clear = true })

		vim.api.nvim_create_autocmd("BufWritePre", {
			command = "EslintFixAll",
			buffer = bufnr,
			group = group,
			desc = "Fix all eslint issues on save",
		})
	end,
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

vim.diagnostic.config({
	virtual_lines = { current_line = true },
})

local group = vim.api.nvim_create_augroup("UserLsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Auto enable LSP completion.
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		-- Disable semantic tokens in favor of Treesitter.
		if client:supports_method("textDocument/semanticTokens") then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
	group = group,
	desc = "Lsp on attach",
})
