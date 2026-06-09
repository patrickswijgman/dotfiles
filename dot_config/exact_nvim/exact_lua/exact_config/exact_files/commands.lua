local lib = require("config.files.lib")

vim.api.nvim_create_user_command("Files", function(opts)
  lib.files(opts.args)
end, {
  complete = function(arglead)
    return lib.get_files(arglead)
  end,
  nargs = "?",
  desc = "Search for files",
})
