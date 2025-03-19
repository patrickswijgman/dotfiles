local M = {}

function M.setup(language_servers)
  local lspconfig = require("lspconfig")

  for _, language_server in ipairs(language_servers) do
    local name = language_server[1]
    local opts = language_server[2] or {}
    lspconfig[name].setup(opts)
  end
end

return M
