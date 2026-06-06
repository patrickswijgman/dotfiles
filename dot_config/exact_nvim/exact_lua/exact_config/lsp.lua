vim.lsp.enable({
  'biome',
  'codebook',
  'jsonls',
  'lua_ls',
  'nixd',
  'vtsls',
})

local code_actions = {
  biome = { "source.fixAll.biome" },
}

local function client_request(client, method, params, bufnr)
  local result = client:request_sync(method, params, 3000, bufnr)

  if result == nil then
    vim.notify(("[LSP] %s: %s failed"):format(client.name, method), vim.log.levels.ERROR)
  elseif result.err then
    vim.notify(("[LSP] %s: %s (%s)"):format(client.name, result.err.message, result.err.data), vim.log.levels.ERROR)
  end

  return result and result.result
end

local group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(ev)
    local clients = vim.lsp.get_clients({ bufnr = ev.buf })

    for _, client in ipairs(clients) do
      local client_code_actions = code_actions[client.name] or {}

      for _, code_action in ipairs(client_code_actions) do
        local params = {
          textDocument = {
            uri = vim.uri_from_bufnr(ev.buf)
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

        local actions = client_request(client, "textDocument/codeAction", params, ev.buf) or {}

        for _, action in ipairs(actions) do
          if not action.edit and not action.command and action.data then
            action = client_request(client, "codeAction/resolve", action, ev.buf) or action
          end

          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
          end

          if action.command then
            client_request(client, "workspace/executeCommand", action.command, ev.buf)
          end
        end
      end
    end
  end,
  desc = "Execute code actions before writing the buffer",
  group = group,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(ev)
    vim.lsp.buf.format({ bufnr = ev.buf })
  end,
  desc = "Format before writing the buffer",
  group = group,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
  desc = "Enable auto completion",
  group = group,
})
