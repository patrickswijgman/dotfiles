-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_group = vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf

		vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { buffer = bufnr, desc = "LSP show function signature" })
		vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { buffer = bufnr, desc = "LSP show diagnostic" })
		vim.keymap.set("n", "cd", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr, desc = "LSP rename" })
		vim.keymap.set("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr, desc = "LSP code action" })
	end,
	group = lsp_group,
	desc = "LSP on attach",
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

lspconfig.taplo.setup({
	capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
})

require("lsp_signature").setup({
	hint_enable = true,
	hint_prefix = {
		above = "↙ ", -- when the hint is on the line above the current line
		current = "← ", -- when the hint is on the same line
		below = "↖ ", -- when the hint is on the line below the current line
	},
})

require("lsp_lines").setup({})

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_text = false,
})
