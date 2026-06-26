local function cmd(command, stdin)
  local result = vim.system(command, { text = true, stdin = stdin }):wait()

  if result.code ~= 0 and result.code ~= 1 then
    vim.notify(("Command failed with error:\n%s"):format(result.stderr), vim.log.levels.ERROR)
    return ""
  end

  return result.stdout
end

local function split_lines(output)
  return vim.split(output, "\n", { trimempty = true })
end

local function get_files(pattern)
  local fd = cmd({ "fd", "--type", "file", "--hidden", "--no-ignore", "--exclude", ".git", "--exclude", "node_modules" })
  local fzf = cmd({ "fzf", "--scheme", "path", "--tiebreak", "pathname", "--filter", pattern }, fd)
  return split_lines(fzf)
end

local function open(opts)
  vim.cmd.edit(opts.args)
end

vim.api.nvim_create_user_command("Files", open, { complete = get_files, nargs = 1, desc = "Search for files" })
