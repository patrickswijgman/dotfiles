-- Editor
vim.o.mouse = "a"
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.scrolloff = 10
vim.o.number = true
vim.o.relativenumber = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"

-- Line wrapping
vim.o.wrap = true
vim.o.breakindent = true
vim.o.showbreak = "↪ "

-- Splitting
vim.o.splitright = true
vim.o.splitbelow = true

-- Persistence
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false

-- Searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.inccommand = "split"

-- Indentation
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

-- Completion
vim.o.completeopt = "menuone,noselect,popup,fuzzy"

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw builtin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
