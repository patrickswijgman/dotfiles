local utils = require("config.utils")

local M = {}

function M.grep(pattern)
  local cmd = { "rg", "--vimgrep", "--smart-case", "--hidden", "--no-ignore", "--glob", "!.git", "--glob", "!node_modules", pattern }
  local lines = utils.cmd_list(cmd)
  utils.sort_on_file_path(lines)

  if #lines == 0 then
    vim.notify(("No matches found for '%s'"):format(pattern), vim.log.levels.WARN)
    return
  end

  local title = ("Grep results for '%s'"):format(pattern)
  utils.set_loc_list(title, lines, "%f:%l:%c:%m")
end

function M.get_words_in_current_buffer(prefix)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local seen = {}
  local words = {}

  for _, line in ipairs(lines) do
    for word in line:gmatch("%w+") do
      if not seen[word] and vim.startswith(word, prefix) then
        seen[word] = true
        words[#words + 1] = word
      end
    end
  end

  table.sort(words)

  return words
end

return M
