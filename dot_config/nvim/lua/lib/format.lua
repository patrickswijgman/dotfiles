return function(bufnr, cmd)
	if cmd then
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local line_count = vim.api.nvim_buf_line_count(bufnr)

		local obj = vim.system(cmd, { text = true, stdin = lines }):wait()

		if obj.code ~= 0 then
			vim.notify(obj.stderr, vim.log.levels.ERROR)
			return
		end

		local text_edit = {
			newText = obj.stdout,
			range = {
				["start"] = { line = 0, character = 0 },
				["end"] = { line = line_count, character = 0 },
			},
		}

		pcall(vim.cmd.undojoin)
		vim.lsp.util.apply_text_edits({ text_edit }, bufnr, "utf-8")
	else
		vim.lsp.buf.format({ async = false, bufnr = bufnr })
	end
end
