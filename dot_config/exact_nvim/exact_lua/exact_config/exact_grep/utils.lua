local M = {}

function M.get_grep_lines(pattern)
  local cmd = { "rg", "--vimgrep", "--hidden", "--glob", "!.git", pattern }

  local result = vim.system(cmd, { text = true }):wait()

  if result.code ~= 0 and result.code ~= 1 then
    vim.notify(("Command failed with error:\n\n%s"):format(result.stderr), vim.log.levels.ERROR)
    return {}
  end

  local lines = vim.split(result.stdout, "\n", { trimempty = true })

  table.sort(lines, function(a, b)
    local a_dir = a:lower():match("^(.*)/") or ""
    local b_dir = b:lower():match("^(.*)/") or ""
    if a_dir ~= b_dir then
      return a_dir < b_dir
    end
    return a:lower() < b:lower()
  end)

  return lines
end

return M
