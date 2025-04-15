local state = require("plugins.files.state")

return function()
	local buf = vim.api.nvim_create_buf(false, true)
	state.set_buf(buf)
end
