vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, {
  desc = "Update plugins",
})

vim.api.nvim_create_user_command("PackList", function()
  vim.pack.update(nil, { offline = true })
end, {
  desc = "List plugins",
})

vim.api.nvim_create_user_command("PackDel", function(opts)
  vim.pack.del(opts.fargs)
end, {
  nargs = "+",
  desc = "Delete plugins",
})
