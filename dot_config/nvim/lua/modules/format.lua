local lsp = require("modules.lsp")

local M = {}

--- Format the buffer.
--- If `cmd` is not given, the LSP's formatter (if it has one) will be used.
function M.format(bufnr, cmd)
  undojoin()

  if cmd == nil then
    lsp.format(bufnr)
  else
    local output = process_buf_content(bufnr, cmd)
    if output ~= nil then
      lsp.text_edit(bufnr, output)
    end
  end
end

return M
