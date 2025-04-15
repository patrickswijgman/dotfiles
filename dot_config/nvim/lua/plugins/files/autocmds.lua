local state = require("plugins.files.state")

local group = vim.api.nvim_create_augroup("PluginFiles", { clear = true })

vim.api.nvim_create_autocmd("BufLeave", {
	callback = function()
		if state.is_current_buffer() then
			vim.api.nvim_buf_delete(state.get_buf(), {})
			state.reset_handles()
		end
	end,
	group = group,
	desc = "Clean up after leaving the files plugin buffer",
})
