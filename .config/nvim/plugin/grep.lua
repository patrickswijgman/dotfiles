local function cmd(command)
  local result = vim.system(command, { text = true }):wait()

  if result.code ~= 0 and result.code ~= 1 then
    vim.notify(("Command failed with error:\n%s"):format(result.stderr), vim.log.levels.ERROR)
    return ""
  end

  return result.stdout
end

local function split_lines(output)
  return vim.split(output, "\n", { trimempty = true })
end

local function sort_items(items)
  table.sort(items, function(a, b)
    local a_file = vim.api.nvim_buf_get_name(a.bufnr):lower()
    local b_file = vim.api.nvim_buf_get_name(b.bufnr):lower()
    local a_dir = a_file:match("^(.*)/") or ""
    local b_dir = b_file:match("^(.*)/") or ""
    local a_line = a.lnum
    local b_line = b.lnum
    local a_col = a.col
    local b_col = b.col
    if a_dir ~= b_dir then
      return a_dir < b_dir
    end
    if a_file ~= b_file then
      return a_file < b_file
    end
    if a_line ~= b_line then
      return a_line < b_line
    end
    return a_col < b_col
  end)
end

local function grep(opts)
  local output = cmd({ "rg", "--vimgrep", "--smart-case", "--hidden", "--no-ignore", "--glob", "!.git", "--glob", "!node_modules", "--", opts.args })
  local lines = split_lines(output)

  if #lines == 0 then
    vim.notify(("No matches found for '%s'"):format(opts.args), vim.log.levels.WARN)
    return
  end

  local title = ("Grep results for '%s'"):format(opts.args)
  local format = "%f:%l:%c:%m"
  local list = vim.fn.getqflist({ efm = format, lines = lines })
  sort_items(list.items)

  vim.fn.setqflist({}, "r", { title = title, items = list.items })
  vim.cmd.copen()
end

local function get_words_in_current_buffer(arglead)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local seen = {}
  local words = {}

  for _, line in ipairs(lines) do
    for word in line:gmatch("%w+") do
      if not seen[word] and vim.startswith(word, arglead) then
        seen[word] = true
        words[#words + 1] = word
      end
    end
  end

  table.sort(words)

  return words
end

vim.api.nvim_create_user_command("Grep", grep, { complete = get_words_in_current_buffer, nargs = 1, desc = "Grep in files" })
