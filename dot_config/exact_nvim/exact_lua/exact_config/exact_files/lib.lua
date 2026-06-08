local utils = require("config.utils")

local M = {}

function M.get_files(pattern, include_dirs)
  local cmd = { "fd", "--type", "file", "--full-path", "--hidden", "--exclude", ".git" }

  if include_dirs then
    table.insert(cmd, "--type")
    table.insert(cmd, "dir")
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
