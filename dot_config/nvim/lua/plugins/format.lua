local formatters = {
	lua = { "stylua", "-" },
	nix = { "nixfmt" },
	fish = {},
	typescript = { "prettierd", ".ts" },
	typescriptreact = { "prettierd", ".tsx" },
	javascript = { "prettierd", ".js" },
	javascriptreact = { "prettierd", ".jsx" },
	html = { "prettierd", ".html" },
	css = { "prettierd", ".css" },
	json = { "prettierd", ".json" },
	jsonc = { "prettierd", ".jsonc" },
	yaml = { "prettierd", ".yaml" },
	markdown = { "prettierd", ".md" },
}

local function format(bufnr, cmd)
	if not vim.bo[bufnr].modified then
		return
	end

	if #cmd == 0 then
		vim.lsp.buf.format({ async = false, bufnr = bufnr })
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local result = vim.system(cmd, { text = true, stdin = lines }):wait()

	if result.code ~= 0 then
		vim.notify(result.stderr, vim.log.levels.ERROR)
		return
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(result.stdout, "\n"))
end

local group = vim.api.nvim_create_augroup("Format", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local cmd = formatters[ft]
		if cmd then
			format(args.buf, cmd)
		end
	end,
	group = group,
	desc = "Format on save",
})

