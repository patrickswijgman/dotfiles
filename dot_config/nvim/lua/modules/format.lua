local M = {}

function M.nixfmt(bufnr)
  undojoin()
  process_buf_content(bufnr, "nixfmt")
end

function M.stylua(bufnr)
  undojoin()
  process_buf_content(bufnr, "stylua -")
end

function M.prettierd(bufnr, parser)
  undojoin()
  process_buf_content(bufnr, fmt("prettierd %s", parser))
end

return M
