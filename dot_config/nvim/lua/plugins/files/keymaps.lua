local core = require("plugins.files.core")

return function(buf)
	vim.keymap.set("n", "<cr>", core.open, { buffer = buf, desc = "Open file" })
	vim.keymap.set("n", "a", core.add, { buffer = buf, desc = "Create new file or directory" })
	vim.keymap.set("n", "m", core.move, { buffer = buf, desc = "Move file or directory" })
	vim.keymap.set("n", "d", core.delete, { buffer = buf, desc = "Delete file or directory" })
	vim.keymap.set("n", "f", core.filter, { buffer = buf, desc = "Filter" })
	vim.keymap.set("n", "F", core.clear_filter, { buffer = buf, desc = "Clear filter" })
	vim.keymap.set("n", "R", core.reload, { buffer = buf, desc = "Reload" })
	vim.keymap.set("n", "q", core.close_window, { buffer = buf, desc = "Close" })
	vim.keymap.set("n", "<esc>", core.close_window, { buffer = buf, desc = "Close" })
end
