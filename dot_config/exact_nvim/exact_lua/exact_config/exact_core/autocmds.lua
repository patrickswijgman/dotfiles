local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  desc = "Highlight on yank",
  group = group,
})
