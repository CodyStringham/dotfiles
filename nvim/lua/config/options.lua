-- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  Options -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- --

local opt = vim.opt

-- Enables 24-bit RGB color
opt.termguicolors = true

-- Adjust color groups for bg type
opt.background = "dark"

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
opt.relativenumber = true

-- Set current line number
opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.undodir = "/tmp/.nvimdid"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10




-- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- --  AutoCmd -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- --

-- Trim whitespace before buffer write
vim.api.nvim_create_autocmd("BufWritePre",
  { pattern = "*", command = [[kz|:%s/\s\+$//e|"z]], desc = "Clear trailing spaces on save" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
