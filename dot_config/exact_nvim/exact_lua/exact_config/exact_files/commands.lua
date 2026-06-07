local utils = require("config.files.utils")

vim.api.nvim_create_user_command('Files', function(opts)
  local pattern = opts.args ~= "" and opts.args or nil
  local cmd = utils.get_command(pattern)

  vim.system(cmd, { text = true }, function(result)
    vim.schedule(function()
      local files = utils.get_files_from_command_result(result)

      if #files == 0 then
        vim.notify(("Files: no files found with pattern '%s'"):format(pattern), vim.log.levels.WARN)
        return
      end

      if #files == 1 then
        vim.cmd.edit(files[1])
        return
      end

      local title = ("Files found with pattern '%s'"):format(pattern)
      local items = vim.tbl_map(function(f) return { filename = f } end, files)

      vim.fn.setqflist({}, "r", { title = title, items = items })
      vim.cmd.copen()
    end)
  end)
end, {
  complete = function(arglead)
    local cmd = utils.get_command(arglead)
    local result = vim.system(cmd, { text = true }):wait()
    return utils.get_files_from_command_result(result)
  end,
  nargs = "?",
  desc = "Search files",
})
