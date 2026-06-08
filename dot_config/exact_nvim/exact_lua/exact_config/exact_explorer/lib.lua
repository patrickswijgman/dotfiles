local utils = require("config.utils")

local M = {}

local buf, win, prev_win, cursor, files, cwd

local function load_files()
  local cmd = { "fd", "--type", "file", "--type", "dir", "--hidden", "--exclude", ".git" }
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
    vim.api.nvim_win_set_config(win, { title = (" %s "):format(cwd), title_pos = "center" })
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
  local path = cwd .. "/" .. vim.api.nvim_get_current_line()
  if vim.fn.isdirectory(path) == 1 then
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

local function refresh()
  load_files()
  set_buf_lines()
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
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)
    vim.bo[buf].modifiable = false
    vim.bo[buf].buftype = "nofile"

    cursor = nil

    local keymap_opts = { buffer = buf, nowait = true }
    vim.keymap.set("n", "<cr>", enter, keymap_opts)
    vim.keymap.set("n", "<bs>", back, keymap_opts)
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
  })

  vim.wo[win].cursorline = true
  vim.fn.matchadd("Directory", ".*/", 10, -1, { window = win })

  if cursor then
    vim.api.nvim_win_set_cursor(win, cursor)
  end
end

return M
