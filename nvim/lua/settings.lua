local set = vim.opt

-- general
set.hidden = true           -- Allows unsaved buffer to be hidden instead of required save
set.backspace = "2"         -- Backspace deletes like most programs in insert mode
set.history = 50            -- Set history to 50
set.ruler = true            -- Show the cursor position all the time
set.showcmd = true          -- Display incomplete commands
set.incsearch = true        -- Do incremental searching
set.laststatus = 2          -- Always display the status line
set.autowrite = true        -- Automatically :write before running commands
set.clipboard = "unnamed"   -- Should always copy to system clipboard
set.mouse = "a"             -- Use the mouse!

-- line number
set.ruler = true
set.number = true
set.numberwidth = 5

-- Persistent Undo
-- set.undofile                " Save undos after file closes
-- set.undodir=$HOME/.vim/undo " where to save undo histories
-- set.undolevels=1000         " How many undos
-- set.undoreload=10000        " number of lines to save for undo

