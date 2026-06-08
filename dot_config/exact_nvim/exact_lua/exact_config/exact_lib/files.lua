local utils = require("config.utils")

local M = {}

M.command_type = {
  FILES = { "file" },
  DIRS = { "dir" },
  FILES_AND_DIRS = { "file", "dir" },
}

function M.get_files(pattern, types)
  local cmd = { "fd", "--full-path", "--hidden", "--exclude", ".git" }

  for _, type in ipairs(types) do
    table.insert(cmd, "--type")
    table.insert(cmd, type)
  end

  table.insert(cmd, pattern)

  local files = utils.cmd_list(cmd)
  utils.sort_on_file_path(files)

  return files
end

function M.show_results(title, files)
  utils.set_loc_list(title, files, "%f")
end

return M
