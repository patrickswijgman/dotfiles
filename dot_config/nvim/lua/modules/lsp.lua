local M = {}

--- Setup language servers.
function M.setup(language_servers)
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local function on_attach(client)
    -- Disable semantic tokens in favor of Treesitter.
    client.server_capabilities.semanticTokensProvider = nil
  end

  for _, language_server in ipairs(language_servers) do
    local name = language_server[1]
    local opts = language_server[2] or {}
    lspconfig[name].setup(merge({ capabilities = capabilities, on_attach = on_attach }, opts))
  end
end

--- Replace the text of a buffer with new text.
function M.text_edit(bufnr, text)
  local end_line = vim.api.nvim_buf_line_count(bufnr)
  local edit = {
    range = {
      ["start"] = {
        line = 0,
        character = 0
      },
      ["end"] = {
        line = end_line,
        character = 0
      }
    },
    newText = text
  }
  vim.lsp.util.apply_text_edits({ edit }, bufnr, "utf-8")
end

--- Format buffer using the LSP's formatter.
function M.format(bufnr)
  vim.lsp.buf.format({ bufnr = bufnr, async = false })
end

--- Go to definition.
function M.go_to_definition()
  vim.lsp.buf.definition()
end

--- Go to references.
function M.go_to_references()
  vim.lsp.buf.references()
end

--- Rename.
function M.rename()
  vim.lsp.buf.rename()
end

--- Code action.
function M.code_action()
  vim.lsp.buf.code_action()
end

--- Show signature help.
function M.show_signature_help()
  vim.lsp.buf.signature_help()
end

--- Show diagnostics.
function M.show_diagnostics()
  vim.diagnostic.setqflist({ open = true })
end

return M
