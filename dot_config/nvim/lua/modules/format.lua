local lsp = require("modules.lsp")

local M = {}

--- Format the buffer. If `cmd` is an empty table, the LSP's formatter (if it has one) will be used.
local function format_buffer(bufnr, cmd)
  undojoin()

  if len(cmd) == 0 then
    lsp.format(bufnr)
  else
    local output = process_buf_content(bufnr, cmd)

    if output ~= nil then
      lsp.text_edit(bufnr, output)
    end
  end
end

--- Setup formatters.
function M.setup(formatters)
  local autocmds = vim.tbl_map(function(formatter)
    local pattern = formatter[1]
    local command = formatter[2]
    return { "BufWritePre", pattern, function(args) format_buffer(args.buf, command) end, fmt("Format %s files", pattern) }
  end, formatters)

  add_autocmds(autocmds)
end

return M
