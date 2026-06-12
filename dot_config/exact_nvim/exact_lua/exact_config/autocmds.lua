local group = vim.api.nvim_create_augroup("Config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  desc = "Highlight on yank",
  group = group,
})
