local utils = require('config.lsp.utils')
local consts = require('config.lsp.consts')

local group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(ev)
    local clients = vim.lsp.get_clients({ bufnr = ev.buf })

    for _, client in ipairs(clients) do
      local client_code_actions = consts.CODE_ACTIONS[client.name] or {}

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

        local actions = utils.client_request(client, "textDocument/codeAction", params, ev.buf) or {}

        for _, action in ipairs(actions) do
          if not action.edit and not action.command and action.data then
            action = utils.client_request(client, "codeAction/resolve", action, ev.buf) or action
          end

          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
          end

          if action.command then
            utils.client_request(client, "workspace/executeCommand", action.command, ev.buf)
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
