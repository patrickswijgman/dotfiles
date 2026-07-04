local line_icons = {
  [vim.diagnostic.severity.ERROR] = "󰅚",
  [vim.diagnostic.severity.WARN] = "󰀪",
  [vim.diagnostic.severity.INFO] = "󰋽",
  [vim.diagnostic.severity.HINT] = "󰌶",
}

local sign_icons = {
  [vim.diagnostic.severity.ERROR] = "󰅚",
  [vim.diagnostic.severity.WARN] = "󰀪",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "",
}

vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    prefix = "",
    format = function(diagnostic)
      return ("%s %s"):format(line_icons[diagnostic.severity], diagnostic.message)
    end,
  },
  signs = {
    text = sign_icons,
  },
})
