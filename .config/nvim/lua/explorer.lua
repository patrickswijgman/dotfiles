local M = {}

local buf
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

local function is_directory(path)
  return vim.endswith(path, "/")
end

-- Create the directory that must exist before mv/cp `src` to `dst`.
-- A file going into `b/` needs `b` created; a dir renamed to `b/` must NOT
-- have `b` pre-created, or mv would nest it as `b/<src>` instead of renaming.
local function ensure_dir(src, dst)
  local dir
  if is_directory(dst) and not is_directory(src) then
    dir = dst:gsub("/+$", "") -- move file into this dir
  else
    dir = get_parent_dir(dst:gsub("/+$", "")) -- rename/move to this path
  end
  cmd({ "mkdir", "-p", dir })
end

local function get_files()
  local output = cmd({ "fd", "--hidden", "--no-ignore", "--exclude", ".git", "--exclude", "node_modules", "--exclude", "dist" })
  local files = split_lines(output)
  sort_lines(files)
  return files
end

local function jump_to(path)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for i, line in ipairs(lines) do
    if line == path then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      return
    end
  end
end

local function create_buf_in_current_win()
  buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "hide"
  vim.api.nvim_set_current_buf(buf)
end

local function update_buf()
  local files = get_files()

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)
  vim.bo[buf].modifiable = false

  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  for i, path in ipairs(files) do
    local is_dir = is_directory(path)
    local icon = is_dir and "󰉋 " or "󰈤 "
    local hl = is_dir and "Directory" or "Normal"

    vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
      virt_text = { { icon, hl } },
      virt_text_pos = "inline",
    })

    local slash = path:match("^.*()/")
    if slash then
      vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
        end_col = slash,
        hl_group = "Directory",
      })
    end
  end
end

local function open()
  local path = vim.api.nvim_get_current_line()
  if path ~= "" and not is_directory(path) then
    vim.cmd.edit(path)
  end
end

local function add()
  local path = vim.api.nvim_get_current_line()

  local dir
  if is_directory(path) then
    dir = path
  else
    local parent_dir = get_parent_dir(path)
    dir = parent_dir == "." and "" or ("%s/"):format(parent_dir)
  end

  local input = vim.fn.input({ prompt = "Add: ", default = dir, completion = "file" })
  if input ~= "" then
    if is_directory(input) then
      cmd({ "mkdir", "-p", input })
    else
      cmd({ "mkdir", "-p", get_parent_dir(input) })
      cmd({ "touch", input })
    end

    update_buf()
    jump_to(input)
  end
end

local function move()
  local src = vim.api.nvim_get_current_line()
  local dst = vim.fn.input({ prompt = "Move: ", default = src, completion = "file" })
  if dst ~= "" then
    ensure_dir(src, dst)
    cmd({ "mv", "-n", src, dst })
    update_buf()
    jump_to(dst)
  end
end

local function copy()
  local src = vim.api.nvim_get_current_line()
  local dst = vim.fn.input({ prompt = "Copy: ", default = src, completion = "file" })
  if dst ~= "" then
    ensure_dir(src, dst)
    cmd({ "cp", "-rn", src, dst })
    update_buf()
    jump_to(dst)
  end
end

local function delete()
  local path = vim.api.nvim_get_current_line()
  local result = vim.fn.confirm(("Delete: %s ?"):format(path), "&Yes\n&No", 2)
  if result == 1 then
    cmd({ "rm", "-rf", path })
    update_buf()
  end
end

local function set_buf_keymaps()
  local opts = { buffer = buf, nowait = true }
  vim.keymap.set("n", "<cr>", open, opts)
  vim.keymap.set("n", "a", add, opts)
  vim.keymap.set("n", "m", move, opts)
  vim.keymap.set("n", "c", copy, opts)
  vim.keymap.set("n", "d", delete, opts)
end

local function explorer()
  local file = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  create_buf_in_current_win()
  set_buf_keymaps()
  update_buf()
  jump_to(file)
end

local function open_on_enter()
  local arg = vim.fn.argv()[1]
  if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
    vim.cmd.cd(arg)
    explorer()
  end
end

function M.setup()
  vim.api.nvim_create_user_command("Explorer", explorer, { desc = "Open Explorer buffer" })

  local group = vim.api.nvim_create_augroup("Explorer", { clear = true })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = open_on_enter,
    desc = "Open Explorer when Neovim is opened with a directory",
    group = group,
  })
end

return M
