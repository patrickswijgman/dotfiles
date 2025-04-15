local state = require("plugins.files.state")
local core = require("plugins.files.core")

return function()
	local group = vim.api.nvim_create_augroup("PluginFiles", { clear = true })

	vim.api.nvim_create_autocmd("WinLeave", {
		callback = function()
			if state.is_current_win() then
				core.close_window()
			end
		end,
		group = group,
		desc = "Clean up after leaving the files plugin window",
	})
end
