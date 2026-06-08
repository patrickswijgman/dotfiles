local files = require("config.lib.files")
local grep = require("config.lib.grep")

vim.api.nvim_create_user_command('Files', function(opts)
  local results = files.get_files(opts.args, files.command_type.FILES)

  if #results == 0 then
    vim.notify(("No files found with pattern '%s'"):format(opts.args), vim.log.levels.WARN)
    return
  end

  if #results == 1 then
    vim.cmd.edit(results[1])
    return
  end

  local title = ("Files found with pattern '%s'"):format(opts.args)
  files.show_results(title, results)
end, {
  complete = function(arglead)
    return files.get_files(arglead, files.command_type.FILES_AND_DIRS)
  end,
  nargs = "?",
  desc = "Search for files",
})

vim.api.nvim_create_user_command('Grep', function(opts)
  local results = grep.grep(opts.args)

  if #results == 0 then
    vim.notify(("No matches found for '%s'"):format(opts.args), vim.log.levels.WARN)
    return
  end

  local title = ("Grep results for '%s'"):format(opts.args)
  grep.show_results(title, results)
end, {
  complete = function(arglead)
    return grep.get_words_in_current_buffer(arglead)
  end,
  nargs = 1,
  desc = "Grep in files",
})
