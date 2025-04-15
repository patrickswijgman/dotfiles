local M = {}

local function command()
	vim.ui.input({ prompt = "Grep: " }, function(input)
		if input and input ~= "" then
			vim.cmd(string.format("silent grep! %s | botright copen", input))
		end
	end)
end

function M.setup()
	vim.api.nvim_create_user_command("Grep", command, { desc = "Grep content" })
end

return M
