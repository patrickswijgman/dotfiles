local M = {}

M.CODE_ACTIONS = {
  biome = { "source.fixAll.biome" },
}

M.FORMATTER_PRIORITY = { 'biome', 'efm' }

M.REQUEST_TIMEOUT = 3000

return M
