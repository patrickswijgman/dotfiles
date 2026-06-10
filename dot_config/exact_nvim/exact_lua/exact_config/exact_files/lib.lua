local utils = require("config.utils")

local M = {}

function M.files(pattern)
  local files = M.get_files(pattern)

  if #files == 0 then
    vim.notify(("No files found with pattern '%s'"):format(pattern), vim.log.levels.WARN)
    return
  end

  vim.cmd.edit(files[1])
end

function M.get_files(pattern)
  local fd = utils.cmd({ "fd", "--type", "file", "--full-path", "--hidden", "--no-ignore", "--exclude", ".git", "--exclude", "node_modules" })
  local fzf = utils.cmd({ "fzf", "--scheme", "path", "--tiebreak", "pathname", "--filter", pattern or "" }, { stdin = fd })
  return utils.split_lines(fzf)
end

return M
