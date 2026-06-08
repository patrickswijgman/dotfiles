local M = {}

function M.setup()
  local path = os.getenv("TREESITTER_PATH")

  if path then
    vim.opt.runtimepath:append(path)
  end
end

return M
