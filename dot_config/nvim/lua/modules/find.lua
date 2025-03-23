local M = {}

function M.find(args)
  cmd("find", args.fargs)
end

function M.find_complete(input)
  local files = shell_list({ "rg", "--files", "--hidden", "--glob=!**/.git/*", })
  local matches = shell_list({ "rg", "--smart-case", input ~= "" and input or "." }, files)
  return shell_list({ "sort" }, matches)
end

function M.grep(args)
  cmd("grep", args.fargs, { bang = true, mods = { silent = true } })
  cmd("cwindow", {}, { mods = { split = "botright" } })
end

return M
