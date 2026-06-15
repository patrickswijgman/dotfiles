local group = vim.api.nvim_create_augroup("Config", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  command = "colorscheme vague",
  desc = "Set colorscheme",
  group = group,
})

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    vim.keymap.set("n", "q", ":cclose<cr>", { buffer = ev.buf, desc = "Close quickfix list" })
  end,
  desc = "Quickfix list keymaps",
  group = group,
})
