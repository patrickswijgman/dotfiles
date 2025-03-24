local M = {}

--- Find content in files and open quickfix list window.
local function grep(args)
  cmd("grep", args.fargs, { bang = true, mods = { silent = true } })
  open_quickfix_window()
end

--- Setup Grep command and grep options.
function M.setup()
  set_options({
    grepprg = "rg --vimgrep --fixed-strings --smart-case --hidden --glob='!**/.git/*'",
  })

  add_commands({
    { "Grep", grep, "Find content in files", { nargs = 1, } }
  })
end

return M
