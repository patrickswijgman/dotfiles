local M = {}

local function find(args)
  vim.cmd("find " .. args.fargs[1])
end

local function find_complete(ArgLead)
  return vim.fn.systemlist("fd --type=file --hidden --exclude='.git' " .. ArgLead)
end

local function grep(args)
  vim.cmd("silent grep! " .. args.fargs[1] .. "| botright copen")
end

function M.setup()
  add_commands({
    { "Find", find, "Find file",             { nargs = 1, complete = find_complete } },
    { "Grep", grep, "Find content in files", { nargs = 1 } },
  })
end

return M
