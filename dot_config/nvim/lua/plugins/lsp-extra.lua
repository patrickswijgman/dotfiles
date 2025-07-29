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

local function diagnostic_format(diagnostic)
  return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
end

require("lsp-extra").setup({
  hover = {
    border = "rounded",
  },
  signature_help = {
    border = "rounded",
  },
  diagnostics = {
    float = {
      border = "rounded",
    },
    virtual_text = {
      current_line = true,
      prefix = "",
      format = diagnostic_format,
    },
    signs = {
      text = signs,
    },
  },
  disable_semantic_tokens = true,
  remove_default_keymaps = true,
  keymaps = {
    code_action = "<leader>a",
    rename = "<leader>r",
    signature_help = "<c-s>",
    hover = "K",
  },
})
