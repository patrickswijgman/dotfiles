-- Enable mouse. Hold <shift> to disable.
vim.o.mouse = "a"

-- Editor.
vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = ""
vim.o.scrolloff = 8
vim.o.wrap = false

-- Default split behavior.
vim.o.splitright = true
vim.o.splitbelow = true

-- Disable backups and swap file, it's annoying.
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false

-- Time in milliseconds when certain updates trigger after being idle in normal mode.
vim.o.updatetime = 50

-- Search.
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- Indentation.
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

-- Spelling.
vim.o.spell = true
vim.o.spelllang = "en_us"
vim.o.spelloptions = "camel"
