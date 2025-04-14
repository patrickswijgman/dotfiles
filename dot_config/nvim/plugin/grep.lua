local function command()
	vim.ui.input({ prompt = "Grep: " }, function(input)
		if input and input ~= "" then
			vim.cmd(string.format("silent grep! %s | botright copen | match Visual /\\c%s/", input, vim.pesc(input)))
		end
	end)
end

vim.api.nvim_create_user_command("Grep", command, { desc = "Grep content" })
