local utils = require("config.files.utils")
local consts = require("config.files.consts")

vim.api.nvim_create_user_command('Files', function(opts)
  local files = utils.get_files(opts.args, consts.command_type.FILES)

  if #files == 0 then
    vim.notify(("No files found with pattern '%s'"):format(opts.args), vim.log.levels.WARN)
    return
  end

  if #files == 1 then
    vim.cmd.edit(files[1])
    return
  end

  local title = ("Files found with pattern '%s'"):format(opts.args)
  local list = vim.fn.getqflist({ efm = "%f", lines = files })

  vim.fn.setloclist(0, {}, "r", { title = title, items = list.items })
  vim.cmd.lopen()
end, {
  complete = function(arglead)
    return utils.get_files(arglead, consts.command_type.FILES_AND_DIRS)
  end,
  nargs = "?",
  desc = "Search for files",
})
