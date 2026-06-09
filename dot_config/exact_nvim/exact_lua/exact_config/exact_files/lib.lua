local utils = require("config.utils")

local M = {}

function M.files(pattern)
  local files = M.get_files(pattern)

  if #files == 0 then
    vim.notify(("No files found with pattern '%s'"):format(pattern), vim.log.levels.WARN)
    return
  end

  if #files == 1 then
    vim.cmd.edit(files[1])
    return
  end

  local title = ("Files found with pattern '%s'"):format(pattern)
  utils.set_loc_list(title, files, "%f")
end

function M.get_files(pattern)
  local cmd = {
    "fd",
    "--type",
    "file",
    "--full-path",
    "--hidden",
    "--no-ignore",
    "--exclude",
    ".git",
    "--exclude",
    "node_modules",
    pattern,
  }
  local files = utils.cmd_list(cmd)
  utils.sort_on_file_path(files)
  return files
end

return M
