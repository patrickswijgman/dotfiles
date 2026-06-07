local lib = require("config.files.lib")
local consts = require("config.files.consts")

vim.api.nvim_create_user_command('Files', function(opts)
  local files = lib.get_files(opts.args, consts.command_type.FILES)

  if #files == 0 then
    vim.notify(("No files found with pattern '%s'"):format(opts.args), vim.log.levels.WARN)
    return
  end

  if #files == 1 then
    vim.cmd.edit(files[1])
    return
  end

  local title = ("Files found with pattern '%s'"):format(opts.args)
  lib.show_results(title, files)
end, {
  complete = function(arglead)
    return lib.get_files(arglead, consts.command_type.FILES_AND_DIRS)
  end,
  nargs = "?",
  desc = "Search for files",
})
