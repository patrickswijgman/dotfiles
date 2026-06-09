local lib = require("config.explorer.lib")

local group = vim.api.nvim_create_augroup("UserExplorerConfig", { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    lib.resize()
  end,
  desc = "Resize explorer window on terminal resize",
  group = group,
})
