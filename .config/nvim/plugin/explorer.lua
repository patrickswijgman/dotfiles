local buf, win, prev_win, cursor
local ns = vim.api.nvim_create_namespace("explorer")

local function cmd(command, stdin)
  local result = vim.system(command, { text = true, stdin = stdin }):wait()

  if result.code ~= 0 then
    vim.notify(("Command failed with error:\n%s"):format(result.stderr), vim.log.levels.ERROR)
    return ""
  end

  return result.stdout
end

local function split_lines(output)
  return vim.split(output, "\n", { trimempty = true })
end

local function sort_lines(lines)
  table.sort(lines, function(a, b)
    local a_path = a:lower()
    local b_path = b:lower()
    local a_dir = a_path:match("^(.*)/") or ""
    local b_dir = b_path:match("^(.*)/") or ""
    if a_dir ~= b_dir then
      return a_dir < b_dir
    end
    return a_path < b_path
  end)
end

local function get_parent_dir(path)
  return vim.fn.fnamemodify(path, ":h")
end

local function is_directory(path, is_on_disk)
  if is_on_disk then
    return vim.fn.isdirectory(path) == 1
  else
    return vim.endswith(path, "/")
  end
end

local function clamp(value, min, max)
  return math.max(min, math.min(max, value))
end

local function get_files()
  local output = cmd({ "fd", "--hidden", "--no-ignore", "--exclude", ".git", "--exclude", "node_modules" })
  local files = split_lines(output)
  sort_lines(files)
  return files
end

local function save_cursor()
  if win and vim.api.nvim_win_is_valid(win) then
    cursor = vim.api.nvim_win_get_cursor(win)
  end
end

local function restore_cursor()
  if cursor and win and vim.api.nvim_win_is_valid(win) then
    local line_count = vim.api.nvim_buf_line_count(buf)
    local row = clamp(cursor[1], 1, line_count)
    local col = cursor[2]
    vim.api.nvim_win_set_cursor(win, { row, col })
  end
end

local function jump_to(path)
  if win and vim.api.nvim_win_is_valid(win) then
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    for i, line in ipairs(lines) do
      if line == path then
        vim.cmd("normal! m'")
        vim.api.nvim_win_set_cursor(win, { i, 0 })
        return
      end
    end
  end
end

local function get_win_config()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local title = (" %s "):format(vim.fn.getcwd())

  return {
    title = title,
    title_pos = "center",
    relative = "editor",
    style = "minimal",
    border = "rounded",
    width = width,
    height = height,
    row = row,
    col = col,
    footer = {
      { " <cr>", "Special" },
      { " open  ", "Comment" },
      { "r", "Special" },
      { " reveal  ", "Comment" },
      { "a", "Special" },
      { " add  ", "Comment" },
      { "m", "Special" },
      { " move  ", "Comment" },
      { "c", "Special" },
      { " copy  ", "Comment" },
      { "d", "Special" },
      { " delete  ", "Comment" },
      { "q", "Special" },
      { " close ", "Comment" },
    },
    footer_pos = "center",
  }
end

local function create_win()
  win = vim.api.nvim_open_win(buf, true, get_win_config())
  vim.wo[win].cursorline = true
  vim.cmd("clearjumps")
  vim.fn.matchadd("Directory", ".*/", -1, -1, { window = win })
end

local function update_win()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_set_config(win, get_win_config())
  end
end

local function close_win()
  save_cursor()

  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
    win = nil
  end

  if prev_win and vim.api.nvim_win_is_valid(prev_win) then
    vim.api.nvim_set_current_win(prev_win)
  end
end

local function redirect_buf()
  if win and vim.api.nvim_win_is_valid(win) and win == vim.api.nvim_get_current_win() then
    local current_buf = vim.api.nvim_get_current_buf()

    if current_buf ~= buf then
      close_win()

      if prev_win and vim.api.nvim_win_is_valid(prev_win) then
        vim.api.nvim_win_set_buf(prev_win, current_buf)
      end
    end
  end
end

local function create_buf()
  buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
end

local function update_buf()
  local files = get_files()

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)
  vim.bo[buf].modifiable = false

  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  for i, path in ipairs(files) do
    local is_dir = is_directory(path)
    local icon = is_dir and " 󰉋 " or " 󰈤 "
    local hl = is_dir and "Directory" or "NormalFloat"

    vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
      virt_text = { { icon, hl } },
      virt_text_pos = "inline",
    })
  end
end

local function reveal()
  if prev_win and vim.api.nvim_win_is_valid(prev_win) then
    local prev_buf = vim.api.nvim_win_get_buf(prev_win)
    local abs_path = vim.api.nvim_buf_get_name(prev_buf)
    local rel_path = vim.fn.fnamemodify(abs_path, ":.")
    jump_to(rel_path)
  end
end

local function open()
  local path = vim.api.nvim_get_current_line()

  if path == "" or is_directory(path) then
    return
  end

  close_win()
  vim.cmd.edit(path)
end

local function add()
  local path = vim.api.nvim_get_current_line()

  local dir
  if is_directory(path) then
    dir = path
  else
    local parent_dir = get_parent_dir(path)
    dir = parent_dir ~= "." and ("%s/"):format(parent_dir) or ""
  end

  local input = vim.fn.input({ prompt = "Add: ", default = dir, completion = "file" })

  if input == "" then
    return
  end

  if is_directory(input) then
    cmd({ "mkdir", "-p", input })
  else
    cmd({ "mkdir", "-p", get_parent_dir(input) })
    cmd({ "touch", input })
  end

  update_buf()
  jump_to(input)
end

local function move()
  local src = vim.api.nvim_get_current_line()
  local dst = vim.fn.input({ prompt = "Move: ", default = src, completion = "file" })

  if dst == "" then
    return
  end

  if is_directory(dst) then
    cmd({ "mkdir", "-p", dst })
  else
    cmd({ "mkdir", "-p", get_parent_dir(dst) })
  end

  cmd({ "mv", "-n", src, dst })

  update_buf()
  jump_to(dst)
end

local function copy()
  local src = vim.api.nvim_get_current_line()
  local dst = vim.fn.input({ prompt = "Copy: ", default = src, completion = "file" })

  if dst ~= "" then
    return
  end

  if is_directory(dst) then
    cmd({ "mkdir", "-p", dst })
  else
    cmd({ "mkdir", "-p", get_parent_dir(dst) })
  end

  cmd({ "cp", "-rn", src, dst })

  update_buf()
  jump_to(dst)
end

local function delete()
  local path = vim.api.nvim_get_current_line()
  local result = vim.fn.confirm(("Delete: %s ?"):format(path), "&Yes\n&No", 2)

  if result ~= 1 then
    return
  end

  cmd({ "rm", "-rf", path })

  update_buf()
end

local function set_buf_keymaps()
  local opts = { buffer = buf, nowait = true }
  vim.keymap.set("n", "<cr>", open, opts)
  vim.keymap.set("n", "r", reveal, opts)
  vim.keymap.set("n", "a", add, opts)
  vim.keymap.set("n", "m", move, opts)
  vim.keymap.set("n", "c", copy, opts)
  vim.keymap.set("n", "d", delete, opts)
  vim.keymap.set("n", "q", close_win, opts)
  vim.keymap.set("n", "<esc>", close_win, opts)
end

local function toggle()
  if win and vim.api.nvim_win_is_valid(win) then
    close_win()
    return
  end

  create_buf()
  set_buf_keymaps()

  prev_win = vim.api.nvim_get_current_win()
  create_win()
  update_buf()
  restore_cursor()
end

local function open_on_enter()
  local arg = vim.fn.argv(0)

  if arg ~= "" and is_directory(arg, true) then
    vim.cmd.cd(arg)
    toggle()
  end
end

vim.api.nvim_create_user_command("Explorer", toggle, { desc = "Toggle explorer" })

local group = vim.api.nvim_create_augroup("Explorer", { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
  callback = update_win,
  desc = "Resize explorer window on terminal resize",
  group = group,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = open_on_enter,
  desc = "Open explorer when Neovim is opened with a directory",
  group = group,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = redirect_buf,
  desc = "Redirect a buffer accidentally opened in the explorer to the previous window",
  group = group,
})
