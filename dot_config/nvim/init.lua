require("lib")

local find = require("modules.find")
local format = require("modules.format")
local fs = require("modules.fs")
local lsp = require("modules.lsp")
local ts = require("modules.treesitter")

set_colorscheme("catppuccin")

set_options({
  mouse = "a",

  number = true,
  cursorline = true,
  signcolumn = "yes",
  colorcolumn = "",
  wrap = false,

  scrolloff = 8,

  splitright = true,
  splitbelow = true,

  undofile = true,
  swapfile = false,
  backup = false,

  updatetime = 50,

  showmatch = true,
  hlsearch = true,
  incsearch = true,

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,

  completeopt = "menu,menuone,popup",

  spell = true,
  spelllang = "en_us",
  spelloptions = "camel",
})

set_global_options({
  mapleader = " ",
})

ts.setup()

lsp.setup({
  { "nixd" },
  {
    "lua_ls",
    {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files.
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
  { "fish_lsp" },
  {
    "ts_ls",
    {
      init_options = {
        preferences = {
          importModuleSpecifierPreference = "non-relative",
          importModuleSpecifierEnding = "js",
        },
      },
    },
  },
  { "eslint" },
  { "tailwindcss" },
  {
    "pyright",
    {
      settings = {
        python = {
          pythonPath = ".venv/bin/python",
        },
      },
    },
  },
  { "ruff" },
  { "gopls" },
  { "golangci_lint_ls" },
  { "jsonls" },
  { "yamlls" },
})

find.setup()

set_keymaps({
  { "n", "<leader>f", ":Find ", "Find file" },
  { "n", "<leader>/", ":Grep ", "Find content in files" },
  { "n", "<leader>b", ":buffer ", "Find a buffer" },

  { "n", "gd", lsp.go_to_definition, "LSP go to definition" },
  { "n", "gr", lsp.go_to_references, "LSP go to references" },
  { "n", "<leader>d", lsp.show_diagnostics, "LSP show diagnostics" },
  { "n", "<leader>r", lsp.rename, "LSP rename" },
  { "n", "<leader>a", lsp.code_action, "LSP code action" },
  { "n,i", "<c-s>", lsp.show_signature_help, "LSP show function signature" },

  { "n,v", "<leader>y", [["+y]], "Yank to system clipboard" },
  { "n,v", "<leader>p", [["+p]], "Paste from system clipboard" },

  { "n", "<c-h>", "<cmd>tabprev<cr>", "Previous tab" },
  { "n", "<c-l>", "<cmd>tabnext<cr>", "Next tab" },
  { "n", "<c-n>", "<cmd>tabnew<cr>", "New tab" },
  { "n", "<c-q>", "<cmd>tabclose<cr>", "Close tab" },

  { "n", "[q", "<cmd>cprev<cr>", "Previous quickfix list item" },
  { "n", "]q", "<cmd>cnext<cr>", "Next quickfix list item" },
  { "n", "<leader>q", "<cmd>copen<cr>", "Open quickfix list" },

  { "n", "<esc>", "<cmd>nohl<cr>", "Clear search highlight", { remap = true } },

  { "n", "q", "<nop>", "Disable macros" },
  { "n", "Q", "<nop>", "Disable macros" },
})

add_autocmds({
  {
    "FileType",
    "checkhealth,qf",
    "set nospell",
    "Disable spelling for certain file types",
  },
  {
    "TextYankPost",
    "*",
    function()
      vim.highlight.on_yank()
    end,
    "Highlight on yank",
  },
  {
    "FileType",
    "nix",
    function()
      format.nixfmt()
    end,
    "Format nix files",
  },
  {
    "FileType",
    "lua",
    function()
      format.stylua()
    end,
    "Format lua files",
  },
  {
    "FileType",
    "typescript",
    function()
      format.prettierd(".ts")
    end,
    "Format typescript files",
  },
  {
    "FileType",
    "typescriptreact",
    function()
      format.prettierd(".tsx")
    end,
    "Format TSX files",
  },
  {
    "BufWritePre",
    "*",
    function(args)
      fs.make_dirs_from_filepath(args.file)
    end,
    "Create the missing directories before creating a file",
  },
})

add_filetypes({
  [".env"] = "properties",
  [".env.*"] = "properties",
  [".env.*.local"] = "properties",
  [".*ignore"] = "gitignore",
})
