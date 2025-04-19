-- General
vim.o.mouse = "a"
vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = ""
vim.o.scrolloff = 8
vim.o.wrap = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 50

-- Persistence
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false

-- Searching
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.inccommand = "split"

-- Indenting
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

-- Folding
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Spelling
-- vim.o.spell = true
-- vim.o.spelllang = "en_us"
-- vim.o.spelloptions = "camel"

-- Disabled builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
