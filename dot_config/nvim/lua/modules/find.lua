local M = {}

local rg_command_flags = "--hidden --glob='!**/.git/*'"
local rg_pattern_flags = "--fixed-strings --smart-case"

local function find(args)
  cmd("find %s", args.fargs[1])
end

local function find_complete(input)
  return cmd_system_list("rg %s --files | rg --sort=path %s %s", rg_command_flags, rg_pattern_flags, input)
end

local function grep(args)
  cmd("silent grep! %s | botright copen", args.fargs[1])
end

function M.setup()
  set_options({
    grepprg = fmt("rg %s --vimgrep %s", rg_command_flags, rg_pattern_flags)
  })

  add_commands({
    { "Find", find, "Find file",             { nargs = 1, complete = find_complete } },
    { "Grep", grep, "Find content in files", { nargs = 1 } },
  })
end

return M
