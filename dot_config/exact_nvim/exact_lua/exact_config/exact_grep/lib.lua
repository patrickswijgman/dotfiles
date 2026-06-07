local utils = require("config.shared.utils")

local M = {}

function M.grep(pattern)
  local cmd = { "rg", "--vimgrep", "--hidden", "--glob", "!.git", pattern }
  local lines = utils.cmd_list(cmd)
  utils.sort_on_file_path(lines)
  return lines
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

function M.show_results(title, lines)
  utils.set_loc_list(title, lines, "%f:%l:%c:%m")
end

return M
