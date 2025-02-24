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

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"

-- Set <leader> key to space.
vim.g.mapleader = " "

-- Disable netrw in favor of a file explorer plugin.
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

-- Set colorscheme.
require("rose-pine")
vim.cmd.colorscheme("rose-pine-moon")

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

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine.
		expand = function(args)
			vim.snippet.expand(args.body) -- For native Neovim snippets (Neovim v0.10+).
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

-- Setup formatter.
require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		_ = { "trim_whitespace" },
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})

-- Setup file picker.
local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				-- Close Telescope when pressing escape instead of going to normal mode.
				["<esc>"] = telescope_actions.close,
			},
		},
		-- Make it possible to grep in hidden files.
		vimgrep_arguments = { "rg", "--vimgrep", "--hidden", "--glob", "!**/.git/*" },
	},
	pickers = {
		find_files = {
			-- Include hidden files when searching for a file.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})

vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>b", telescope_builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>h", telescope_builtin.help_tags, { desc = "Telescope help tags" })

-- Setup file explorer.
require("neo-tree").setup({})
vim.keymap.set("n", "<leader>e", "<cmd>Neotree<cr>", { desc = "Neo-tree open" })
