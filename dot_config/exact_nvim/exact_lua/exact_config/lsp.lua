vim.lsp.enable({
  "biome",
  "codebook",
  "efm",
  "fish_lsp",
  "jsonls",
  "lua_ls",
  "nixd",
  "vtsls",
})

vim.lsp.semantic_tokens.enable(false)

local CODE_ACTIONS = {
  biome = { "source.fixAll.biome" },
}

local FORMATTER_PRIORITY = { "biome", "efm" }

local function client_request(client, method, params, bufnr)
  local result = client:request_sync(method, params, 3000, bufnr)

  if result == nil then
    vim.notify(("[LSP] %s: %s failed"):format(client.name, method), vim.log.levels.ERROR)
  elseif result.err then
    vim.notify(("[LSP] %s: %s (%s)"):format(client.name, result.err.message, result.err.data), vim.log.levels.ERROR)
  end

  return result and result.result
end

local function get_code_actions(name)
  return CODE_ACTIONS[name] or {}
end

local function get_code_action_params(code_action, bufnr)
  return {
    textDocument = {
      uri = vim.uri_from_bufnr(bufnr),
    },
    range = {
      ["start"] = { line = 0, character = 0 },
      ["end"] = { line = 0, character = 0 },
    },
    context = {
      only = { code_action },
      diagnostics = {},
    },
  }
end

local function get_preferred_formatter(bufnr)
  for _, name in ipairs(FORMATTER_PRIORITY) do
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = name, method = "textDocument/formatting" })[1]

    if client then
      return name
    end
  end
end

return {
  client_request = client_request,
  get_code_actions = get_code_actions,
  get_code_action_params = get_code_action_params,
  get_preferred_formatter = get_preferred_formatter,
}
