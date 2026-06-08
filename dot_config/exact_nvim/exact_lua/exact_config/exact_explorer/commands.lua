local lib = require("config.explorer.lib")

vim.api.nvim_create_user_command("Explorer", function()
  lib.toggle()
end, {
  desc = "Open file explorer in a floating window",
})
