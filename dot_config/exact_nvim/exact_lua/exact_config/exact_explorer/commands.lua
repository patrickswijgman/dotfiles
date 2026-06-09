local lib = require("config.explorer.lib")

vim.api.nvim_create_user_command("Explorer", function()
  lib.toggle()
end, {
  desc = "Toggle file explorer",
})
