local fs = require("modules.fs")

local M = {}

--- Find a file.
local function find(args)
  cmd("find", args.fargs)
end

--- Setup Find command.
function M.setup()
  add_commands({
    { "Find", find, "Find file", { nargs = 1, complete = fs.list_files } }
  })
end

return M
