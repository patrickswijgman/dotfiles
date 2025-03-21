local M = {}

function M.setup(language_servers)
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  for _, language_server in ipairs(language_servers) do
    local name = language_server[1]
    local opts = language_server[2] or {}
    lspconfig[name].setup(merge({ capabilities = capabilities }, opts))
  end
end

function M.go_to_definition()
  vim.lsp.buf.definition()
end

function M.go_to_references()
  vim.lsp.buf.references()
end

function M.rename()
  vim.lsp.buf.rename()
end

function M.code_action()
  vim.lsp.buf.code_action()
end

function M.show_signature_help()
  vim.lsp.buf.signature_help()
end

function M.show_diagnostics()
  vim.diagnostic.setqflist({ open = true })
end

function M.format()
  vim.lsp.buf.format({ async = false })
end

return M
