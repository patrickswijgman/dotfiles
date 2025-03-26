local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
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

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})
