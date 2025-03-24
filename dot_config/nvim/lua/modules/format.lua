local lsp = require("modules.lsp")

local M = {}

--- Format the buffer. If `cmd` is an empty table, the LSP's formatter (if it has one) will be used.
local function format(bufnr, cmd)
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
  for pattern, cmd in pairs(formatters) do
    add_autocmds({
      { "BufWritePre", pattern, function(args) format(args.buf, cmd) end, string.format("Format %s files", pattern) },
    })
  end
end

return M
