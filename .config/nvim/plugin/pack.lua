local function update_plugins()
  vim.pack.update()
end

local function list_plugins()
  vim.pack.update(nil, { offline = true })
end

local function delete_plugins(opts)
  vim.pack.del(opts.fargs)
end

vim.api.nvim_create_user_command("PackUpdate", update_plugins, { desc = "Update plugins" })
vim.api.nvim_create_user_command("PackList", list_plugins, { desc = "List plugins" })
vim.api.nvim_create_user_command("PackDel", delete_plugins, { nargs = "+", desc = "Delete plugins" })
vim.api.nvim_create_user_command("PackInfo", "checkhealth vim.pack", { desc = "Package manager information" })
