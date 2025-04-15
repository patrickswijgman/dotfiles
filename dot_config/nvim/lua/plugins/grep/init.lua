local lib = require("lib")

local M = {}

local function command()
	vim.ui.input({ prompt = "Grep: " }, function(input)
		if input and input ~= "" then
			vim.cmd(string.format("silent grep! %s", input))
			vim.cmd("botright copen")
			lib.utils.highlight(input)
		end
	end)
end

function M.setup()
	vim.api.nvim_create_user_command("Grep", command, { desc = "Grep content" })
end

return M
