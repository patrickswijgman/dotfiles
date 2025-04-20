local oil = require("oil")

oil.setup({
  view_options = {
    show_hidden = true,
  },
})

local function open()
  oil.open(nil, { preview = { vertical = true } })
end

vim.keymap.set("n", "-", open, { desc = "Open parent directory" })
