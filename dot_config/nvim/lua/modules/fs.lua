local M = {}

function M.make_dirs_from_filepath(file)
  vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
end

function M.make_dirs_from_filepath_autocmd(args)
  M.make_dirs_from_filepath(args.file)
end

return M

