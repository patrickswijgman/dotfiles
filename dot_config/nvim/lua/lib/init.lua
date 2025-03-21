function _G.merge(...)
  return vim.tbl_extend("force", ...)
end

function _G.split(str)
  local t = {}
  for word in string.gmatch(str, "%a+") do
    t[#t + 1] = word
  end
  return t
end

function _G.fmt(str, ...)
  return string.format(str, ...)
end

function _G.cmd(cmd, ...)
  vim.cmd(fmt(cmd, ...))
end

function _G.cmd_system(cmd, ...)
  return vim.fn.system(fmt(cmd, ...))
end

function _G.cmd_system_list(cmd, ...)
  return vim.fn.systemlist(fmt(cmd, ...))
end

function _G.set_colorscheme(colorscheme)
  vim.cmd.colorscheme(colorscheme)
end

function _G.process_buf_content(bufnr, cmd)
  local input = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local output = vim.fn.systemlist(cmd, input)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
end

function _G.undojoin()
  -- undojoin may fail when joined with another undo, use pcall to ignore the error.
  pcall(vim.cmd.undojoin)
end

function _G.set_options(options)
  for key, value in pairs(options) do
    vim.o[key] = value
  end
end

function _G.set_global_options(options)
  for key, value in pairs(options) do
    vim.g[key] = value
  end
end

function _G.set_keymaps(keymaps)
  for _, keymap in ipairs(keymaps) do
    local mode = keymap[1]
    local lhs = keymap[2]
    local rhs = keymap[3]
    local desc = keymap[4]
    local opts = keymap[5] or {}
    vim.keymap.set(split(mode), lhs, rhs, merge({ desc = desc }, opts))
  end
end

local group = vim.api.nvim_create_augroup("Config", { clear = true })

function _G.add_autocmds(cmds)
  for _, cmd in ipairs(cmds) do
    local event = cmd[1]
    local pattern = cmd[2]
    local handler = cmd[3]
    local desc = cmd[4]

    local is_command = type(handler) == "string"

    local opts = {
      pattern = pattern,
      group = group,
      desc = desc,
    }

    if is_command then
      opts["command"] = handler
    else
      opts["callback"] = handler
    end

    vim.api.nvim_create_autocmd(event, opts)
  end
end

function _G.add_filetypes(pattern)
  vim.filetype.add({ pattern = pattern })
end

function _G.add_commands(cmds)
  for _, cmd in ipairs(cmds) do
    local name = cmd[1]
    local handler = cmd[2]
    local desc = cmd[3]
    local opts = cmd[4] or {}
    vim.api.nvim_create_user_command(name, handler, merge({ desc = desc }, opts))
  end
end
