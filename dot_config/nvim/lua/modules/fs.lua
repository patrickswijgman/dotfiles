local M = {}

--- Create any missing intermediate directories for a given file path.
function M.make_dirs_from_filepath(file)
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
end

return M
