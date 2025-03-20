require("lib")

local ts = require("modules.treesitter")
local lsp = require("modules.lsp")
local find = require("modules.find")
local fs = require("modules.fs")

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

  completeopt = "menuone,preview",

  path = ".,**",

  grepprg = "rg --vimgrep --smart-case --hidden --glob='!**/.git/*'",

  spell = true,
  spelllang = "en_us",
  spelloptions = "camel",
})

set_global_options({
  mapleader = " "
})

ts.setup()

lsp.setup({
  { "nixd" },
  { "lua_ls", {
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
  } },
  { "fish_lsp" },
  { "ts_ls", {
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "non-relative",
        importModuleSpecifierEnding = "js",
      },
    },
  } },
  { "eslint" },
  { "tailwindcss" },
  { "pyright", {
    settings = {
      python = {
        pythonPath = ".venv/bin/python",
      },
    },
  } },
  { "ruff" },
  { "gopls" },
  { "golangci_lint_ls" },
  { "jsonls" },
  { "yamlls" },
})

find.setup()

set_keymaps({
  { "n",   "<leader>f", ":Find ",             "Find file", },
  { "n",   "<leader>/", ":Grep ",             "Find content in files", },
  { "n",   "<leader>b", ":buffer ",           "Find a buffer", },
  { "n",   "gd",        lsp.go_to_definition, "LSP go to definition", },
  { "n",   "gr",        lsp.go_to_references, "LSP go to references", },
  { "n",   "<leader>d", lsp.diagnostics,      "LSP show diagnostics", },
  { "n",   "<leader>r", lsp.rename,           "LSP rename", },
  { "n",   "<leader>a", lsp.code_action,      "LSP code action", },
  { "n,i", "<c-s>",     lsp.signature_help,   "LSP show function signature", },
  { "n,v", "<leader>y", [["+y]],              "Yank to system clipboard" },
  { "n,v", "<leader>p", [["+p]],              "Paste from system clipboard" },
  { "n",   "<c-h>",     "<c-w>h",             "Go to the left window" },
  { "n",   "<c-j>",     "<c-w>j",             "Go to the down window" },
  { "n",   "<c-k>",     "<c-w>k",             "Go to the up window" },
  { "n",   "<c-l>",     "<c-w>l",             "Go to the right window" },
  { "n",   "[q",        "<cmd>cprev<cr>",     "Previous quickfix list item" },
  { "n",   "]q",        "<cmd>cnext<cr>",     "Next quickfix list item" },
  { "n",   "<leader>q", "<cmd>copen<cr>",     "Open quickfix list" },
  { "n",   "<esc>",     "<cmd>nohl<cr>",      "Clear search highlight",      { remap = true } },
  { "n",   "q",         "<nop>",              "Disable macros" },
  { "n",   "Q",         "<nop>",              "Disable macros" },
})

add_autocmds({
  { "FileType",     "checkhealth,qf", "set nospell",                          "Disable spelling for certain file types" },
  { "TextYankPost", "*",              function() vim.highlight.on_yank() end, "Highlight on yank" },
  { "BufWritePre",  "*",              lsp.format,                             "Format on save" },
  { 'BufWritePre',  "*",              fs.make_dirs_from_filepath_autocmd,     "Create the missing directories before creating a file" }
})

add_filetypes({
  [".env"] = "properties",
  [".env.*"] = "properties",
  [".env.*.local"] = "properties",
  [".*ignore"] = "gitignore",
})
