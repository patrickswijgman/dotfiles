vim.o.mouse = "a"

vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = ""
vim.o.scrolloff = 8
vim.o.wrap = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false

vim.o.updatetime = 50

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.inccommand = "split"

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

vim.o.winborder = "rounded"

vim.o.path = ".,**"
vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob='!**/.git/*'"
vim.o.completeopt = "menu,menuone,popup,noselect,fuzzy"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
