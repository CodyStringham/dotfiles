-- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Options -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- --

local opt = vim.opt

-- Enables 24-bit RGB color
opt.termguicolors = true

-- Adjust color groups for bg type
opt.background = "light"

-- Set number of spaces for <Tab>
opt.tabstop = 2

-- Set umber of spaces to use for each step of (auto)indent.
opt.shiftwidth = 2

-- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
opt.expandtab = true

-- Copy indent from current line when starting a new line
opt.autoindent = true

-- File-content encoding for the current buffer
opt.fileencoding = "utf-8"

-- Disable swap (recovery) file
opt.swapfile = false

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make relative line numbers default
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.undodir = "/tmp/.nvimdid"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10




-- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  AutoCmd -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- --

-- Trim whitespace on save
vim.api.nvim_create_autocmd("BufWritePre",
  { pattern = "*", command = [[kz|:%s/\s\+$//e|"z]], desc = "Clear trailing spaces on save" })

