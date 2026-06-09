local lib = require("config.grep.lib")

vim.api.nvim_create_user_command("Grep", function(opts)
  lib.grep(opts.args)
end, {
  complete = function(arglead)
    return lib.get_words_in_current_buffer(arglead)
  end,
  nargs = 1,
  desc = "Grep in files",
})
