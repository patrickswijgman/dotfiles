local consts = require("config.files.consts")
local utils = require("config.utils")

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

  local files = utils.cmd_list(cmd)
  utils.sort_on_file_path(files)

  return files
end

function M.show_results(title, files)
  utils.set_loc_list(title, files, "%f")
end

return M
