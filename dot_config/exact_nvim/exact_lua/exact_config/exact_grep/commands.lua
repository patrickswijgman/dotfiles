local utils = require("config.grep.utils")

vim.api.nvim_create_user_command('Grep', function(opts)
  local lines = utils.get_grep_lines(opts.args)

  if #lines == 0 then
    vim.notify(("No matches found for '%s'"):format(opts.args), vim.log.levels.WARN)
    return
  end

  local title = ("Grep results for '%s'"):format(opts.args)
  local list = vim.fn.getqflist({ efm = "%f:%l:%c:%m", lines = lines })

  vim.fn.setloclist(0, {}, "r", { title = title, items = list.items })
  vim.cmd.lopen()
end, {
  complete = function(arglead)
    return utils.get_words_in_buffer(arglead)
  end,
  nargs = 1,
  desc = "Grep in files",
})
