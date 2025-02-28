-- Enable mouse, hold shift to disable it.
vim.opt.mouse = "a"

-- General settings.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = ""

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- Set default splitting behavior.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Persist undo stack between sessions.
vim.opt.undofile = true

-- Disable swap file, it's annoying.
vim.opt.swapfile = false
vim.opt.backup = false

-- CursorHold event update time.
vim.opt.updatetime = 50

-- Search options.
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Set indentation to 2 spaces (convert tabs as well).
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Enable spelling.
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
