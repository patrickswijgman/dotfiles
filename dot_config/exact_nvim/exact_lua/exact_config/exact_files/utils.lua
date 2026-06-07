local consts = require("config.files.consts")

local M = {}

function M.get_files(pattern, type)
  local cmd = { "fd", "--full-path", "--hidden", "--exclude", ".git" }

  if type == consts.command_type.FILES then
    table.insert(cmd, "--type")
    table.insert(cmd, "file")
  elseif type == consts.command_type.DIRS then
    table.insert(cmd, "--type")
    table.insert(cmd, "dir")
  elseif type == consts.command_type.FILES_AND_DIRS then
    table.insert(cmd, "--type")
    table.insert(cmd, "file")
    table.insert(cmd, "--type")
    table.insert(cmd, "dir")
  end

  table.insert(cmd, pattern)

  local result = vim.system(cmd, { text = true }):wait()

  if result.code ~= 0 then
    vim.notify(("Files: command failed with error:\n\n%s"):format(result.stderr or ""), vim.log.levels.ERROR)
    return {}
  end

  local files = vim.split(result.stdout, "\n", { trimempty = true })

  table.sort(files, function(a, b)
    local a_dir = a:lower():match("^(.*)/") or ""
    local b_dir = b:lower():match("^(.*)/") or ""
    if a_dir ~= b_dir then
      return a_dir < b_dir
    end
    return a:lower() < b:lower()
  end)

  return files
end

return M
