local lib = require("config.grep.lib")

vim.api.nvim_create_user_command('Grep', function(opts)
  local lines = lib.grep(opts.args)

  if #lines == 0 then
    vim.notify(("No matches found for '%s'"):format(opts.args), vim.log.levels.WARN)
    return
  end

  local title = ("Grep results for '%s'"):format(opts.args)
  lib.show_results(title, lines)
end, {
  complete = function(arglead)
    return lib.get_words_in_current_buffer(arglead)
  end,
  nargs = 1,
  desc = "Grep in files",
})
