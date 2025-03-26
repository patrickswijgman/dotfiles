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

		["<up>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<down>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<cr>"] = cmp.mapping.confirm({ select = false }),

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
