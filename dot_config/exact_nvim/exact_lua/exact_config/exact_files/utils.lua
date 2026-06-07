local M = {}

function M.get_command(pattern)
  local cmd = { "fd", "--type", "file", "--hidden", "--exclude", ".git" }

  if pattern then
    if pattern:find("[*?{[]") then
      table.insert(cmd, "--glob")
    else
      table.insert(cmd, "--full-path")
    end

    table.insert(cmd, pattern)
  end

  return cmd
end

function M.get_files_from_command_result(result)
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
