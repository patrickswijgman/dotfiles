local M = {}

function M.setup()
  set_options({
    grepprg = "rg --vimgrep --fixed-strings --smart-case --hidden --glob='!**/.git/*'",
  })

  add_commands({
    {
      "Find",
      function(args)
        cmd("find %s", args.fargs[1])
      end,
      "Find file",
      {
        nargs = 1,
        complete = function(input)
          return cmd_system_list("rg --files --hidden --glob='!**/.git/*' | rg --sort=path --smart-case %s", input ~= "" and input or ".")
        end,
      },
    },

    {
      "Grep",
      function(args)
        cmd("silent grep! %s | botright copen", args.fargs[1])
      end,
      "Find content in files",
      {
        nargs = 1,
      },
    },
  })
end

return M
