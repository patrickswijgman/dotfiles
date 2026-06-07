local consts = require('config.lsp.consts')

local M = {}

function M.client_request(client, method, params, bufnr)
  local result = client:request_sync(method, params, consts.REQUEST_TIMEOUT, bufnr)

  if result == nil then
    vim.notify(("[LSP] %s: %s failed"):format(client.name, method), vim.log.levels.ERROR)
  elseif result.err then
    vim.notify(("[LSP] %s: %s (%s)"):format(client.name, result.err.message, result.err.data), vim.log.levels.ERROR)
  end

  return result and result.result
end

function M.get_code_actions(name)
  return consts.CODE_ACTIONS[name] or {}
end

function M.get_code_action_params(code_action, bufnr)
  return {
    textDocument = {
      uri = vim.uri_from_bufnr(bufnr)
    },
    range = {
      ["start"] = { line = 0, character = 0 },
      ["end"] = { line = 0, character = 0 },
    },
    context = {
      only = { code_action },
      diagnostics = {}
    },
  }
end

function M.get_preferred_formatter(bufnr)
  for _, name in ipairs(consts.FORMATTER_PRIORITY) do
    if vim.lsp.get_clients({ bufnr = bufnr, name = name, method = 'textDocument/formatting' })[1] then
      return name
    end
  end
end

return M
