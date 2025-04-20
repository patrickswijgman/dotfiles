local signs = {
  [vim.diagnostic.severity.ERROR] = "󰅚",
  [vim.diagnostic.severity.WARN] = "󰀪",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "",
}

local icons = {
  [vim.diagnostic.severity.ERROR] = "󰅚",
  [vim.diagnostic.severity.WARN] = "󰀪",
  [vim.diagnostic.severity.INFO] = "󰋽",
  [vim.diagnostic.severity.HINT] = "󰌶",
}

local function format(diagnostic)
  return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
end

vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    prefix = "",
    format = format,
  },
  signs = {
    text = signs,
  },
})
