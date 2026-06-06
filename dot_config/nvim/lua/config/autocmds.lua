local group = vim.api.nvim_create_augroup('UserConfig', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  desc = "Highlight on yank",
  group = group,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(ev)
    vim.fn.mkdir(vim.fn.fnamemodify(ev.file, ":h:p"), "p")
  end,
  desc = "Create intermediate directories before writing the buffer",
  group = group,
})
