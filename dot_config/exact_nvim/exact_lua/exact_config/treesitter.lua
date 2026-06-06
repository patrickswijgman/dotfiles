local path = os.getenv("TREESITTER_PATH")
if path then
  vim.opt.runtimepath:append(path)
end

local group = vim.api.nvim_create_augroup('UserTreesitterConfig', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
  desc = "Enable treesitter highlighting",
  group = group,
})
