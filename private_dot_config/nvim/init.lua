-- Set options.
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = ""
vim.opt.scrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 50
vim.opt.termguicolors = true

vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- vim.opt.spell = true
-- vim.opt.spelllang = "en_us"
-- vim.opt.spelloptions = "camel"

-- Set <leader> key to space.
vim.g.mapleader = " "

-- Disable netrw in favor if a file exporer plugin.
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

-- Set colorscheme.
require("catppuccin")
vim.cmd.colorscheme("catppuccin")

-- Setup syntax highlighting with Treesitter.
require("nvim-treesitter.configs").setup({
	auto_install = false,
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

-- Setup session management.
require("auto-session").setup({})
-- For a better experience with the plugin overall using this config for sessionoptions is recommended:
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Setup auto completion.
local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<c-y>"] = cmp.mapping.confirm({ select = true }),
		["<c-space>"] = cmp.mapping.complete(),
		["<c-d>"] = cmp.mapping.scroll_docs(-4),
		["<c-u>"] = cmp.mapping.scroll_docs(4),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- Setup language servers.
-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local lspconfig = require("lspconfig")
local capabilities = cmp_lsp.default_capabilities()

local on_attach = function(client)
	-- Disable semantic tokens (if the language has them) in favor of Treesitter.
	client.server_capabilities.semanticTokensProvider = nil
end

lspconfig["nixd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
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

lspconfig["ts_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		init_options = {
			preferences = {
				importModuleSpecifierPreference = "non-relative",
				importModuleSpecifierEnding = "js",
			},
		},
	},
})

lspconfig["eslint"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Setup formatter.
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})

-- Setup picker.
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Telescope help tags" })

-- Setup file explorer.
require("neo-tree").setup({})
