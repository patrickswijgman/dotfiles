-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { buffer = bufnr, desc = "LSP go to definition" })
		vim.keymap.set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { buffer = bufnr, desc = "LSP go to type definition" })
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { buffer = bufnr, desc = "LSP go to references" })
		vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { buffer = bufnr, desc = "LSP function signature" })
		vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { buffer = bufnr, desc = "LSP show diagnostic" })
		vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr, desc = "LSP rename" })
		vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr, desc = "LSP code action" })
	end,
})

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
	settings = {
		init_options = {
			preferences = {
				importModuleSpecifierPreference = "non-relative",
				importModuleSpecifierEnding = "js",
			},
		},
	},
})

lspconfig.eslint.setup({
	capabilities = capabilities,
})

lspconfig.taplo.setup({
	capabilities = capabilities,
})
