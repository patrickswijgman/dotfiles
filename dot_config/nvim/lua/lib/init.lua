--- Merge one or more tables into the first.
function _G.merge(...)
  return vim.tbl_extend("force", ...)
end

--- Split a string on a given delimiter.
function _G.split(str, delimiter)
  return vim.split(str, delimiter, { plain = true, trimempty = true })
end

--- Get the length of a table.
function _G.len(tbl)
  return vim.tbl_count(tbl)
end

--- Format a string.
function _G.fmt(str, args)
  return string.format(str, args)
end

--- Execute a Vim command.
function _G.cmd(cmd, args, opts)
  vim.api.nvim_cmd(merge({ cmd = cmd, args = args }, opts or {}), {})
end

--- Execute a shell command.
function _G.shell(cmd, input)
  local job = vim.system(cmd, { text = true, stdin = input }):wait()

  if job.code ~= 0 and job.stderr ~= "" then
    vim.notify(job.stderr, vim.log.levels.ERROR)
    return nil
  end

  return job.stdout
end

--- Execute a shell command and return the output as a list.
function _G.shell_list(cmd, input)
  local output = shell(cmd, input)

  if output == nil then
    return {}
  end

  return split(output, "\n")
end

--- Execute a shell command with the buffer's content as stdin.
function _G.process_buf_content(bufnr, cmd)
  return shell(cmd, vim.api.nvim_buf_get_lines(bufnr, 0, -1, false))
end

--- Open the quickfix list window.
function _G.open_quickfix_window()
  cmd("cwindow", {}, { mods = { split = "botright" } })
end

--- Do not add the next action to the undo stack.
function _G.undojoin()
  -- undojoin may fail when joined with another undo, use pcall to ignore the error.
  pcall(vim.cmd.undojoin)
end

--- Set colorscheme.
function _G.set_colorscheme(colorscheme)
  vim.cmd.colorscheme(colorscheme)
end

--- Set one or more options.
function _G.set_options(options)
  for key, value in pairs(options) do
    vim.opt[key] = value
  end
end

--- Set one or more global options.
function _G.set_global_options(options)
  for key, value in pairs(options) do
    vim.g[key] = value
  end
end

--- Set one or more keymaps.
function _G.set_keymaps(keymaps)
  for _, keymap in ipairs(keymaps) do
    local mode = keymap[1]
    local lhs = keymap[2]
    local rhs = keymap[3]
    local desc = keymap[4]
    local opts = keymap[5] or {}
    vim.keymap.set(split(mode, ","), lhs, rhs, merge({ desc = desc }, opts))
  end
end

--- Add one or more user commands.
function _G.add_commands(cmds)
  for _, cmd in ipairs(cmds) do
    local name = cmd[1]
    local handler = cmd[2]
    local desc = cmd[3]
    local opts = cmd[4] or {}
    vim.api.nvim_create_user_command(name, handler, merge({ desc = desc }, opts))
  end
end

local group = vim.api.nvim_create_augroup("Config", { clear = true })

--- Add one or more autocommands.
function _G.add_autocmds(cmds)
  for _, cmd in ipairs(cmds) do
    local event = cmd[1]
    local pattern = cmd[2]
    local handler = cmd[3]
    local desc = cmd[4]

    local opts = {
      pattern = pattern,
      group = group,
      desc = desc,
    }

    if type(handler) == "string" then
      opts["command"] = handler
    else
      opts["callback"] = handler
    end

    vim.api.nvim_create_autocmd(event, opts)
  end
end

--- Add one or more filetype associations.
function _G.add_filetypes(pattern)
  vim.filetype.add({ pattern = pattern })
end
