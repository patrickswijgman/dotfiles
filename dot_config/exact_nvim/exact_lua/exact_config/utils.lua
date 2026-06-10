local M = {}

function M.set_qf_list(title, lines, format)
  local list = vim.fn.getqflist({ efm = format, lines = lines })
  vim.fn.setqflist({}, "r", { title = title, items = list.items })
  vim.cmd.copen()
end

function M.set_loc_list(title, lines, format)
  local list = vim.fn.getqflist({ efm = format, lines = lines })
  vim.fn.setloclist(0, {}, "r", { title = title, items = list.items })
  vim.cmd.lopen()
end

function M.cmd(cmd, opts)
  local system_opts = vim.tbl_extend("force", { text = true }, opts or {})
  local result = vim.system(cmd, system_opts):wait()
  if result.code ~= 0 and result.code ~= 1 then
    vim.notify(("Command failed with error:\n%s"):format(result.stderr), vim.log.levels.ERROR)
    return ""
  end
  return result.stdout
end

function M.split_lines(output)
  return vim.split(output, "\n", { trimempty = true })
end

function M.clamp(value, min, max)
  return math.min(max, math.max(value, min))
end

return M
