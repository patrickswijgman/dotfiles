local M = {}

function M.client_request(client, method, params, bufnr)
  local result = client:request_sync(method, params, 3000, bufnr)

  if result == nil then
    vim.notify(("[LSP] %s: %s failed"):format(client.name, method), vim.log.levels.ERROR)
  elseif result.err then
    vim.notify(("[LSP] %s: %s (%s)"):format(client.name, result.err.message, result.err.data), vim.log.levels.ERROR)
  end

  return result and result.result
end

return M
