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

require("wizard").setup({
  options = {
    mouse = "a",
    number = true,
    relativenumber = true,
    cursorline = true,
    signcolumn = "yes",
    colorcolumn = "",
    scrolloff = 8,
    wrap = true,
    splitright = true,
    splitbelow = true,
    updatetime = 50,

    undofile = true,
    swapfile = false,
    backup = false,

    smartcase = true,
    ignorecase = true,
    showmatch = true,
    hlsearch = true,
    incsearch = true,
    inccommand = "split",

    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    autoindent = true,

    foldenable = true,
    foldlevel = 99,
    foldmethod = "expr",
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
  },

  global_options = {
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
  },

  colorscheme = "vague",
  useExperimentalLoader = true,
  plugins = {
    {
      "nvim-autopairs",
    },
    {
      "blink.cmp",
      {
        completion = {
          menu = {
            border = "rounded",
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 50,
            window = {
              border = "rounded",
            },
          },
        },
        signature = {
          enabled = true,
          window = {
            border = "rounded",
          },
        },
      },
    },
    {
      "conform",
      {
        formatters_by_ft = {
          javascript = { "biome", "prettierd", stop_after_first = true },
          typescript = { "biome", "prettierd", stop_after_first = true },
          javascriptreact = { "biome", "prettierd", stop_after_first = true },
          typescriptreact = { "biome", "prettierd", stop_after_first = true },
          html = { "prettierd" },
          css = { "prettierd" },
          json = { "biome", "prettierd", stop_after_first = true },
          jsonc = { "biome", "prettierd", stop_after_first = true },
          yaml = { "prettierd" },
          markdown = { "prettierd" },
          lua = { "stylua" },
          nix = { "nixfmt" },
          go = { "gofmt" },
          rust = { "rustfmt" },
          python = { "ruff" },
          toml = { "taplo" },
          _ = { "trim_whitespace" },
        },
        format_on_save = {
          timeout_ms = 2000,
          lsp_format = "fallback",
        },
      },
    },
    {
      "copilot",
      {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
        },
      },
    },
    {
      "lsp-extra",
      {
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
            format = function(diagnostic)
              return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
            end,
          },
          signs = {
            text = signs,
          },
        },
        disable_semantic_tokens = true,
        keymaps = {
          signature_help = "<c-s>",
          hover = "K",
        },
      },
    },
    {
      "lualine",
      {
        options = {
          component_separators = "",
          disabled_filetypes = {
            statusline = { "NvimTree" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {},
          lualine_c = { "diagnostics", { "filename", path = 1 } },
          lualine_x = { "filetype", "location", "progress" },
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      },
    },
    {
      "nvim-tree",
      {
        view = {
          width = {},
        },
        git = {
          enable = false,
        },
        modified = {
          enable = true,
        },
        filters = {
          enable = false,
        },
      },
    },
    {
      "spectre",
      {
        open_cmd = "tabnew",
      },
    },
    {
      "spider",
      {
        skipInsignificantPunctuation = false,
        consistentOperatorPending = false,
        subwordMovement = true,
      },
    },
    {
      "nvim-surround",
    },
    {
      "telescope",
      {
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = "top",
              width = { padding = 8 },
              height = { padding = 2 },
              preview_width = 0.5,
            },
          },
          path_display = {
            "filename_first",
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<c-up>"] = require("telescope.actions").cycle_history_prev,
              ["<c-down>"] = require("telescope.actions").cycle_history_next,
              ["<tab>"] = require("telescope.actions.layout").toggle_preview,
              ["<esc>"] = require("telescope.actions").close,
            },
          },
          vimgrep_arguments = { "rg", "--vimgrep", "--smart-case", "--hidden", "--glob=!**/.git/*" },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type=file", "--hidden", "--exclude=.git" },
          },
        },
      },
    },
    {
      "nvim-treesitter.configs",
      {
        highlight = {
          enable = true,
        },
      },
    },
    {
      "various-textobjs",
      {
        keymaps = {
          useDefaults = true,
        },
      },
    },
    {
      "zen-mode",
      {
        window = {
          width = 1,
          height = 1,
        },
      },
    },
  },

  leader = " ",
  keymaps = {
    { "j", "v:count == 0 ? 'gj' : 'j'", "Down (including wrapped lines)", { mode = { "n", "x" }, isExpression = true } },
    { "k", "v:count == 0 ? 'gk' : 'k'", "Up (including wrapped lines)", { mode = { "n", "x" }, isExpression = true } },
    { "w", "<cmd>lua require('spider').motion('w')<cr>", "Next word", { mode = { "n", "o", "x" } } },
    { "e", "<cmd>lua require('spider').motion('e')<cr>", "Next end of word", { mode = { "n", "o", "x" } } },
    { "b", "<cmd>lua require('spider').motion('b')<cr>", "Prev word", { mode = { "n", "o", "x" } } },
    { "R", '"0p', "Replace with last yanked text", { mode = "x" } },
    { "q", "<nop>", "Disable macros" },
    { "Q", "<nop>", "Disable macros" },
    { "s", "<plug>(leap)", "Leap to word", { mode = { "n", "x", "o" } } },
    { "grd", require("telescope.builtin").lsp_definitions, "Go to LSP definitions" },
    { "grt", require("telescope.builtin").lsp_type_definitions, "Go to LSP type definitions" },
    { "gri", require("telescope.builtin").lsp_implementations, "Go to LSP implementations" },
    { "grr", require("telescope.builtin").lsp_references, "Go to LSP references" },
    { "grs", require("telescope.builtin").lsp_document_symbols, "LSP document symbols" },
    { "grS", require("telescope.builtin").lsp_workspace_symbols, "LSP workspace symbols" },
    { "<c-h>", "<cmd>tabprev<cr>", "Go to previous tab" },
    { "<c-l>", "<cmd>tabnext<cr>", "Go to next tab" },
    { "<c-t>", "<cmd>tabnew<cr>", "New tab" },
    { "<c-q>", "<cmd>tabclose<cr>", "Close tab" },
    { "<m-h>", "<c-w>h", "Go to left window" },
    { "<m-j>", "<c-w>j", "Go to lower window" },
    { "<m-k>", "<c-w>k", "Go to upper window" },
    { "<m-l>", "<c-w>l", "Go to right window" },
    { "<m-q>", "<c-w>q", "Close window" },
    { "<leader>e", require("telescope.builtin").diagnostics, "Diagnostics" },
    { "<leader>f", require("telescope.builtin").find_files, "Find file" },
    { "<leader>/", require("telescope.builtin").live_grep, "Grep content" },
    { "<leader>b", require("telescope.builtin").buffers, "Find buffer" },
    { "<leader>h", require("telescope.builtin").help_tags, "Find help" },
    { "<leader>'", require("telescope.builtin").resume, "Resume picker" },
    { "<leader>e", "<cmd>NvimTreeOpen<cr>", "Open file explorer" },
    { "<leader>E", "<cmd>NvimTreeFindFile<cr>", "Open file explorer at current file" },
    { "<leader>s", "<cmd>Spectre<cr>", "Find and replace" },
    { "<leader>z", "<cmd>ZenMode<cr>", "Toggle Zen mode" },
    { "<leader>y", '"+y', "Yank to system clipboard", { mode = { "n", "x" } } },
    { "<leader>p", '"+p', "Paste from system clipboard", { mode = { "n", "x" } } },
    { "<leader>P", '"+P', "Paste from system clipboard", { mode = { "n", "x" } } },
    { "<leader>R", '"+p', "Replace with text from system clipboard", { mode = "x" } },
    { "<esc>", "<cmd>nohl<cr>", "Clear search highlight" },
  },

  autocmds = {
    {
      "TextYankPost",
      function()
        vim.hl.on_yank()
      end,
      "Highlight on yank",
    },
    {
      "BufWritePre",
      function(args)
        vim.fn.mkdir(vim.fn.fnamemodify(args.file, ":h:p"), "p")
      end,
      "Create intermediate directories before writing the buffer",
    },
  },

  lsp = {
    {
      "nixd",
    },
    {
      "lua_ls",
      {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      },
    },
    {
      "vtsls",
      {
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            preferences = {
              importModuleSpecifier = "non-relative",
              importModuleSpecifierEnding = "js",
            },
            updateImportsOnFileMove = {
              enabled = "always",
            },
            suggest = {
              completeFunctionCalls = true,
            },
          },
        },
      },
    },
    {
      "biome",
    },
    {
      "tailwindcss",
    },
    {
      "codebook",
    },
    {
      "taplo",
    },
    {
      "jsonls",
      {
        settings = {
          json = {
            schemas = {
              {
                fileMatch = { "package.json" },
                url = "https://www.schemastore.org/package.json",
              },
              {
                fileMatch = { "tsconfig.json" },
                url = "https://www.schemastore.org/tsconfig.json",
              },
            },
          },
        },
      },
    },
    {
      "yamlls",
    },
    {
      "pyright",
    },
    {
      "ruff",
    },
    {
      "gopls",
    },
  },
})
