local M = {}

function M.set_loc_list(title, lines, format)
  local list = vim.fn.getqflist({ efm = format, lines = lines })
  vim.fn.setloclist(0, {}, "r", { title = title, items = list.items })
  vim.cmd.lopen()
end

function M.cmd_list(cmd)
  local result = vim.system(cmd, { text = true }):wait()

  if result.code ~= 0 and result.code ~= 1 then
    vim.notify(("Command failed with error:\n\n%s"):format(result.stderr), vim.log.levels.ERROR)
    return {}
  end

  return vim.split(result.stdout, "\n", { trimempty = true })
end

function M.sort_on_file_path(lines)
  table.sort(lines, function(a, b)
    local a_dir = a:lower():match("^(.*)/") or ""
    local b_dir = b:lower():match("^(.*)/") or ""

    if a_dir ~= b_dir then
      return a_dir < b_dir
    end

    return a:lower() < b:lower()
  end)
end

return M
