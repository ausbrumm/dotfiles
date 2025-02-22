vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

--  Relative line numbers
opt.relativenumber = true
opt.number = true

-- tabas & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

vim.opt.signcolumn = 'yes'
opt.wrap = false

-- search settings
opt.ignorecase = true -- case insensitive search
opt.smartcase = true -- uses mixed case for case sensitive search

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- disable mouse
opt.mouse = ""

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or insertmode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- LSP Server to use for Rust.
-- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "bacon-ls"
vim.g.lazyvim_prettier_needs_config = false
