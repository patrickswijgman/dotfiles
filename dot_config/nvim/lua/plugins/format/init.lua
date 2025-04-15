local M = {}

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

	local text_edit = {
		newText = result.stdout,
		range = {
			["start"] = { line = 0, character = 0 },
			["end"] = { line = #lines, character = 0 },
		},
	}

	vim.lsp.util.apply_text_edits({ text_edit }, bufnr, "utf-8")
end

local group = vim.api.nvim_create_augroup("PluginFormat", { clear = true })

local function setup_autocmd(filetype, cmd)
	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function(args)
			if vim.bo[args.buf].filetype == filetype then
				format(args.buf, cmd)
			end
		end,
		group = group,
		desc = string.format("Format %s on save", filetype),
	})
end

function M.setup(formatters)
	for filetype, cmd in pairs(formatters) do
		setup_autocmd(filetype, cmd)
	end
end

return M
