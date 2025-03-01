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
		go = { "gofmt" },
		rust = { "rustfmt" },
		toml = { "taplo" },
		_ = { "trim_whitespace" },
	},
	format_on_save = {
		timeout_ms = 2000, -- Increase timeout as Prettier is sometimes pretty slow.
		lsp_format = "fallback",
	},
})
