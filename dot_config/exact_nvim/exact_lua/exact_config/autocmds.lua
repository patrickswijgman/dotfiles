local group = vim.api.nvim_create_augroup("Config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  desc = "Highlight on yank",
  group = group,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  desc = "Remove trailing whitespaces before writing the buffer",
  group = group,
})
