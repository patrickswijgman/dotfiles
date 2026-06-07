local M = {}

function M.get_grep_lines(pattern)
  local cmd = { "rg", "--vimgrep", "--hidden", "--glob", "!.git", pattern }

  local result = vim.system(cmd, { text = true }):wait()

  if result.code == 2 then
    vim.notify(("Command failed with error:\n\n%s"):format(result.stderr), vim.log.levels.ERROR)
    return {}
  end

  return vim.split(result.stdout, "\n", { trimempty = true })
end

return M
