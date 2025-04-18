local oil = require("oil")

oil.setup({
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name)
			local m = name:match("^oil:")
			return m ~= nil
		end,
	},
})

local function open()
	oil.open(nil, { preview = { vertical = true } })
end

vim.keymap.set("n", "-", open, { desc = "Open parent directory" })
