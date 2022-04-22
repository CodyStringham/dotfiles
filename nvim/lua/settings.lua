local set = vim.opt

-- general
set.hidden = true           -- Allows unsaved buffer to be hidden instead of required save
set.backspace = '2'         -- Backspace deletes like most programs in insert mode
set.history = 50            -- Set history to 50
set.ruler = true            -- Show the cursor position all the time
set.showcmd = true          -- Display incomplete commands
set.incsearch = true        -- Do incremental searching
set.laststatus = 2          -- Always display the status line
set.autowrite = true        -- Automatically :write before running commands
set.clipboard = 'unnamed'   -- Should always copy to system clipboard
set.mouse = 'a'             -- Use the mouse!

-- line number
set.ruler = true
set.number = true
set.numberwidth = 5

-- Softtabs, 2 spaces
set.tabstop = 2
set.shiftwidth = 2
set.shiftround = true
set.expandtab = true

-- Splits
set.splitbelow = true
set.splitright = true

-- buffers
vim.cmd[[
  nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
  nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
  map <silent> <Leader>x :BD<CR>
]]

-- Get off my lawn
vim.keymap.set('n', '<Left>', ':echoe "Use h"<CR>', { noremap = true})
vim.keymap.set('n', '<Right>', ':echoe "Use l"<CR>', { noremap = true})
vim.keymap.set('n', '<Up>', ':echoe "Use k"<CR>', { noremap = true})
vim.keymap.set('n', '<Down>', ':echoe "Use j"<CR>', { noremap = true})

-- clear highlight
vim.keymap.set('n', '<leader>h', ':noh<CR>')

-- Persistent Undo
vim.cmd[[
  set undofile                 " Save undos after file closes
  set undodir=$HOME/.nvim/undo " Where to save undo histories
  set undolevels=1000          " How many undos
  set undoreload=10000         " Number of lines to save for undo
]]

-- Colors
vim.cmd [[
  syntax on
  set cursorline
  colorscheme nord

  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  if (has("termguicolors"))
    set termguicolors
  endif
]]
