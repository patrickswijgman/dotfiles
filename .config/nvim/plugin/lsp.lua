local enabled = {
  "biome",
  "codebook",
  "cssls",
  "cssmodules_ls",
  "docker_language_server",
  "efm",
  "emmet_language_server",
  "fish_lsp",
  "golangci_lint_server",
  "gopls",
  "jinja_lsp",
  "jsonls",
  "lua_ls",
  "nixd",
  "pylsp",
  "ruff",
  "rust_analyzer",
  "stylua",
  "taplo",
  "vtsls",
  "yamlls",
}

local formatter_priority = { "biome", "efm" }
local code_actions = { biome = { "source.fixAll.biome" } }
local timeout_ms = 1000

local chars = {}
for i = 32, 126 do
  table.insert(chars, string.char(i))
end

local function client_request(client, method, params, bufnr)
  local result = client:request_sync(method, params, timeout_ms, bufnr)

  if result == nil then
    vim.notify(("[LSP] %s: %s failed"):format(client.name, method), vim.log.levels.ERROR)
  elseif result.err then
    vim.notify(("[LSP] %s: %s (%s)"):format(client.name, result.err.message, result.err.data), vim.log.levels.ERROR)
  end

  return result and result.result
end

local function get_code_action_params(code_action, bufnr)
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local last_line = vim.api.nvim_buf_get_lines(bufnr, -2, -1, false)[1] or ""

  return {
    textDocument = {
      uri = vim.uri_from_bufnr(bufnr),
    },
    range = {
      ["start"] = { line = 0, character = 0 },
      ["end"] = { line = line_count - 1, character = #last_line },
    },
    context = {
      only = { code_action },
      diagnostics = {},
    },
  }
end

local function get_preferred_formatter(bufnr)
  for _, name in ipairs(formatter_priority) do
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = name, method = "textDocument/formatting" })[1]
    if client then
      return name
    end
  end
end

local function format(ev)
  local clients = vim.lsp.get_clients({ bufnr = ev.buf, method = "textDocument/codeAction" })

  for _, client in ipairs(clients) do
    local client_code_actions = code_actions[client.name] or {}

    for _, code_action in ipairs(client_code_actions) do
      local params = get_code_action_params(code_action, ev.buf)
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

  vim.lsp.buf.format({
    bufnr = ev.buf,
    name = get_preferred_formatter(ev.buf),
    timeout_ms = timeout_ms,
  })
end

local function auto_complete(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if client and client:supports_method("textDocument/completion") then
    client.server_capabilities.completionProvider.triggerCharacters = chars
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
  end
end

vim.lsp.enable(enabled)
vim.lsp.semantic_tokens.enable(false)

local group = vim.api.nvim_create_augroup("Lsp", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = format,
  desc = "Apply LSP code actions and format before writing the buffer",
  group = group,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = auto_complete,
  desc = "Handle LSP auto completion",
  group = group,
})
