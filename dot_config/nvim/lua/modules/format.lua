local M = {}

local function add_format_on_save_autocmd(cmd)
  add_autocmds({
    {
      "BufWritePre",
      "*",
      function(args)
        process_buf_content(args.buf, cmd)
      end,
      "Format on save",
    },
  })
end

function M.nixfmt()
  add_format_on_save_autocmd("nixfmt")
end

function M.stylua()
  add_format_on_save_autocmd("stylua -")
end

function M.prettierd(parser)
  add_format_on_save_autocmd(fmt("prettierd %s", parser))
end

return M
