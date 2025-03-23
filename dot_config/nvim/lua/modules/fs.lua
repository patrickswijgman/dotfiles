local M = {}

--- Get a list of files filtered by the given pattern.
function M.list_files(pattern)
  local files = shell_list({ "rg", "--files", "--hidden", "--glob=!**/.git/*" })
  local filtered = shell_list({ "rg", pattern }, files)
  local sorted = shell_list({ "sort" }, filtered)

  return sorted
end

--- Create any missing intermediate directories for a given file path.
function M.make_dirs_from_filepath(file)
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
end

return M
