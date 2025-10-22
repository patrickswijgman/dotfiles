vim.loader.enable()

require("wizard").setup({
  --------------------
  -- Editor options --
  --------------------

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
    mapleader = " ",

    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
  },

  -----------------
  -- Colorscheme --
  -----------------

  colorscheme = "catppuccin",

  -------------
  -- Plugins --
  -------------

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
        renderer = {
          special_files = {},
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
      "actions-preview",
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
          width = 200,
          height = 1,
        },
      },
    },
  },

  -------------
  -- Keymaps --
  -------------

  keymaps = {
    -- Normal mode
    {
      "n",
      "K",
      function()
        vim.lsp.buf.hover({ border = "rounded" })
      end,
    },
    { "n", "gra", require("actions-preview").code_actions },
    { "n", "grt", require("telescope.builtin").lsp_type_definitions },
    { "n", "gri", require("telescope.builtin").lsp_implementations },
    { "n", "grr", require("telescope.builtin").lsp_references },
    { "n", "grO", require("telescope.builtin").lsp_workspace_symbols },
    { "n", "gO", require("telescope.builtin").lsp_document_symbols },
    { "n", "<c-]>", require("telescope.builtin").lsp_definitions },
    { "n", "<c-h>", "<cmd>tabprev<cr>" },
    { "n", "<c-l>", "<cmd>tabnext<cr>" },
    { "n", "<c-t>", "<cmd>tabnew<cr>" },
    { "n", "<c-q>", "<cmd>tabclose<cr>" },
    { "n", "<m-h>", "<c-w>h" },
    { "n", "<m-j>", "<c-w>j" },
    { "n", "<m-k>", "<c-w>k" },
    { "n", "<m-l>", "<c-w>l" },
    { "n", "<m-q>", "<c-w>q" },
    { "n", "<leader>d", require("telescope.builtin").diagnostics },
    { "n", "<leader>f", require("telescope.builtin").find_files },
    { "n", "<leader>/", require("telescope.builtin").live_grep },
    { "n", "<leader>?", require("telescope.builtin").grep_string },
    { "n", "<leader>b", require("telescope.builtin").buffers },
    { "n", "<leader>h", require("telescope.builtin").help_tags },
    { "n", "<leader>'", require("telescope.builtin").resume },
    { "n", "<leader>e", "<cmd>NvimTreeOpen<cr>" },
    { "n", "<leader>E", "<cmd>NvimTreeFindFile<cr>" },
    { "n", "<leader>s", "<cmd>Spectre<cr>" },
    { "n", "<leader>z", "<cmd>ZenMode<cr>" },
    { "n", "<esc>", "<cmd>nohl<cr>" },
    { "n", "q", "<nop>" },
    { "n", "Q", "<nop>" },

    -- Normal and insert modes
    {
      { "n", "i" },
      "<c-s>",
      function()
        vim.lsp.buf.signature_help({ border = "rounded" })
      end,
    },

    -- Visual mode
    { "x", "R", '"0p' },
    { "x", "<leader>R", '"+p' },

    -- Normal and visual modes
    { { "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true } },
    { { "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true } },
    { { "n", "x" }, "<leader>y", '"+y' },
    { { "n", "x" }, "<leader>p", '"+p' },
    { { "n", "x" }, "<leader>P", '"+P' },

    -- Normal, operator-pending, and visual modes
    { { "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<cr>" },
    { { "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<cr>" },
    { { "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<cr>" },
    { { "n", "o", "x" }, "s", "<plug>(leap)" },
  },

  -------------------
  -- Auto commands --
  -------------------

  autocmds = {
    {
      "TextYankPost",
      {
        callback = function()
          vim.hl.on_yank()
        end,
        desc = "Highlight on yank",
      },
    },
    {
      "BufWritePre",
      {
        callback = function(args)
          vim.fn.mkdir(vim.fn.fnamemodify(args.file, ":h:p"), "p")
        end,
        desc = "Create intermediate directories before writing the buffer",
      },
    },
    {
      "BufWritePre",
      {
        pattern = "*",
        callback = function(args)
          local conform = require("conform")

          local conform_opts = {
            bufnr = args.buf,
            lsp_format = "fallback",
            timeout_ms = 2000,
          }

          local code_actions = {
            biome = { "source.fixAll.biome", "source.organizeImports.biome" },
          }

          local clients = vim.lsp.get_clients({ bufnr = args.buf })

          for _, client in ipairs(clients) do
            local client_code_actions = code_actions[client.name]

            if client_code_actions then
              vim.lsp.buf.code_action({ context = { only = client_code_actions, diagnostics = {} }, apply = true })
            end
          end

          conform.format(conform_opts)
        end,
        desc = "Format before save",
      },
    },
  },

  -----------------
  -- Diagnostics --
  -----------------

  diagnostics = {
    float = {
      border = "rounded",
    },

    virtual_text = {
      current_line = true,
      prefix = "",
      format = function(diagnostic)
        local icons = {
          [vim.diagnostic.severity.ERROR] = "󰅚",
          [vim.diagnostic.severity.WARN] = "󰀪",
          [vim.diagnostic.severity.INFO] = "󰋽",
          [vim.diagnostic.severity.HINT] = "󰌶",
        }

        return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
      end,
    },

    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚",
        [vim.diagnostic.severity.WARN] = "󰀪",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      },
    },
  },

  ----------------------------
  -- Language servers (LSP) --
  ----------------------------

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
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      },
    },
    {
      "vtsls",
      {
        settings = {
          javascript = {
            preferences = {
              importModuleSpecifier = "non-relative",
              importModuleSpecifierEnding = "js",
            },
          },
          typescript = {
            preferences = {
              importModuleSpecifier = "non-relative",
              importModuleSpecifierEnding = "js",
            },
          },
        },
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
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
    {
      "fish_lsp",
    },
  },

  ---------------------------
  -- Filetype associations --
  ---------------------------

  filetypes = {
    pattern = {
      [".*%.env.*"] = "properties",
      [".*config"] = "properties",
      [".*config%.tmpl"] = "properties",
      [".*%.kdl%.tmpl"] = "kdl",
      [".*%.ini%.tmpl"] = "dosini",
      [".*%.css%.tmpl"] = "css",
    },
  },
})
