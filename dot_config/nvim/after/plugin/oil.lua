require("oil").setup({
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name)
			local m = name:match("^oil:")
			return m ~= nil
		end,
	},
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
