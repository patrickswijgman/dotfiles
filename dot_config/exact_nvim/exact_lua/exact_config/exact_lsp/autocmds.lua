local lib = require("config.lsp.lib")

local group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(ev)
    local clients = vim.lsp.get_clients({ bufnr = ev.buf })

    for _, client in ipairs(clients) do
      local client_code_actions = lib.get_code_actions(client.name)

      for _, code_action in ipairs(client_code_actions) do
        local params = lib.get_code_action_params(code_action, ev.buf)
        local actions = lib.client_request(client, "textDocument/codeAction", params, ev.buf) or {}

        for _, action in ipairs(actions) do
          if not action.edit and not action.command and action.data then
            action = lib.client_request(client, "codeAction/resolve", action, ev.buf) or action
          end

          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
          end
        end
      end
    end

    vim.lsp.buf.format({
      bufnr = ev.buf,
      name = lib.get_preferred_formatter(ev.buf),
    })
  end,
  desc = "Apply code actions and format before writing the buffer",
  group = group,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
  desc = "Enable auto completion",
  group = group,
})
