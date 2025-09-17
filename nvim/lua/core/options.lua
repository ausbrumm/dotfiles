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
opt.smartcase = true  -- uses mixed case for case sensitive search

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- In your init.lua or init.vim
vim.opt.mouse = 'a'
vim.opt.mousemoveevent = true
vim.opt.scrolloff = 5     -- Keep 5 lines visible above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor

-- Disable cursor positioning with mouse clicks
vim.keymap.set({ 'n', 'i', 'v' }, '<LeftMouse>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<2-LeftMouse>', '<Nop>') -- Double click word selection
vim.keymap.set({ 'n', 'i', 'v' }, '<LeftDrag>', '<Nop>')    -- Click and drag selection
vim.keymap.set('n', '<ScrollWheelUp>', '3<C-y>')
vim.keymap.set('n', '<ScrollWheelDown>', '3<C-e>')
vim.keymap.set('i', '<ScrollWheelUp>', '<C-o>3<C-y>')
vim.keymap.set('i', '<ScrollWheelDown>', '<C-o>3<C-e>')
vim.keymap.set('v', '<ScrollWheelUp>', '3<C-y>')
vim.keymap.set('v', '<ScrollWheelDown>', '3<C-e>')

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or insertmode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- disabling need for prettier config
vim.g.lazyvim_prettier_needs_config = false
