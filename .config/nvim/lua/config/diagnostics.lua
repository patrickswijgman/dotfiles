local icons = {
  [vim.diagnostic.severity.ERROR] = "󰅚",
  [vim.diagnostic.severity.WARN] = "󰀪",
  [vim.diagnostic.severity.INFO] = "󰋽",
  [vim.diagnostic.severity.HINT] = "󰌶",
}

local hl = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticError",
  [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticHint",
}

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = icons,
  },
  status = {
    format = function(counts)
      local parts = {}
      for severity, count in vim.spairs(counts) do
        table.insert(parts, ("%%#%s#%s %d"):format(hl[severity], icons[severity], count))
      end
      return table.concat(parts, " ") .. "%#StatusLine#"
    end,
  },
})
