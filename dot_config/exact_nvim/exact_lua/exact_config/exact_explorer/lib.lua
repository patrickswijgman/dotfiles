local utils = require("config.utils")

local M = {}

local buf, win, prev_win, cursor, files, cwd, query

local function load_files()
  local cmd = { "fd", "--type", "file", "--type", "dir", "--hidden", "--exclude", ".git", "--full-path", query }
  local list = utils.cmd_list(cmd, cwd)
  utils.sort_on_file_path(list)
  files = list
end

local function set_buf_lines()
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)
  vim.bo[buf].modifiable = false
end

local function update_title()
  if win and vim.api.nvim_win_is_valid(win) then
    local title = (query and query ~= "") and (" %s [%s] "):format(cwd, query) or (" %s "):format(cwd)
    vim.api.nvim_win_set_config(win, { title = title, title_pos = "center" })
  end
end

local function close()
  if win and vim.api.nvim_win_is_valid(win) then
    cursor = vim.api.nvim_win_get_cursor(win)
    vim.api.nvim_win_close(win, true)
    win = nil
  end
end

local function navigate(dir)
  cwd = dir:gsub("/$", "")
  cursor = nil
  load_files()
  set_buf_lines()
  update_title()
end

local function enter()
  local path = ("%s/%s"):format(cwd, vim.api.nvim_get_current_line())
  if vim.endswith(path, "/") then
    navigate(path)
  else
    close()
    if prev_win and vim.api.nvim_win_is_valid(prev_win) then
      vim.api.nvim_set_current_win(prev_win)
    end
    vim.cmd.edit(path)
  end
end

local function back()
  local parent = vim.fn.fnamemodify(cwd, ":h")
  if parent ~= cwd then
    navigate(parent)
  end
end

local function add()
  local dir = ("%s/"):format(cwd)
  local input = vim.fn.input({ prompt = "New: ", default = dir, completion = "file" })
  if input == "" then
    return
  end
  if vim.endswith(input, "/") then
    vim.fn.mkdir(input, "p")
    load_files()
    set_buf_lines()
  else
    close()
    if prev_win and vim.api.nvim_win_is_valid(prev_win) then
      vim.api.nvim_set_current_win(prev_win)
    end
    vim.cmd.edit(input)
  end
end

local function delete()
  local line = vim.api.nvim_get_current_line()
  local path = ("%s/%s"):format(cwd, line)
  if vim.fn.confirm(("Delete %s?"):format(line), "&Yes\n&No", 2) ~= 1 then
    return
  end
  vim.fn.delete(path, "rf")
  load_files()
  set_buf_lines()
end

local function move()
  local line = vim.api.nvim_get_current_line()
  local src = ("%s/%s"):format(cwd, line)
  local dst = vim.fn.input({ prompt = "Move to: ", default = src, completion = "file" })
  if dst == "" or dst == src then
    return
  end
  vim.fn.mkdir(vim.fn.fnamemodify(dst, ":h"), "p")
  vim.uv.fs_rename(src, dst)
  load_files()
  set_buf_lines()
end

local function filter()
  local input = vim.fn.input("Filter: ", query or "")
  query = (input ~= "") and input or nil
  load_files()
  set_buf_lines()
  update_title()
end

local function refresh()
  query = nil
  load_files()
  set_buf_lines()
  update_title()
end

function M.toggle()
  if win and vim.api.nvim_win_is_valid(win) then
    close()
    return
  end

  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    cwd = vim.fn.getcwd()
    load_files()

    buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = "nofile"
    set_buf_lines()

    cursor = nil

    local keymap_opts = { buffer = buf, nowait = true }
    vim.keymap.set("n", "<cr>", enter, keymap_opts)
    vim.keymap.set("n", "<bs>", back, keymap_opts)
    vim.keymap.set("n", "a", add, keymap_opts)
    vim.keymap.set("n", "d", delete, keymap_opts)
    vim.keymap.set("n", "m", move, keymap_opts)
    vim.keymap.set("n", "f", filter, keymap_opts)
    vim.keymap.set("n", "R", refresh, keymap_opts)
    vim.keymap.set("n", "q", close, keymap_opts)
    vim.keymap.set("n", "<esc>", close, keymap_opts)
  end

  prev_win = vim.api.nvim_get_current_win()

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " " .. cwd .. " ",
    title_pos = "center",
    footer = {
      { " <cr>", "Special" }, { " open  ", "Comment" },
      { "<bs>",  "Special" }, { " back  ", "Comment" },
      { "a", "Special" }, { " add  ", "Comment" },
      { "d", "Special" }, { " delete  ", "Comment" },
      { "m", "Special" }, { " move  ", "Comment" },
      { "f", "Special" }, { " filter  ", "Comment" },
      { "R", "Special" }, { " refresh  ", "Comment" },
      { "q", "Special" }, { " close ", "Comment" },
    },
    footer_pos = "center",
  })

  vim.wo[win].cursorline = true
  vim.fn.matchadd("Directory", ".*/", -1, -1, { window = win })
  update_title()

  if cursor then
    vim.api.nvim_win_set_cursor(win, cursor)
  end
end

return M
