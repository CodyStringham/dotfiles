vim.g.mapleader = " "

local keymap = vim.keymap
local smart = require("smart-splits")

-- Search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Buffers
keymap.set("n", "<tab>", ":bnext<cr>", { desc = "next buffer", silent = true })
keymap.set("n", "<s-tab>", ":bprevious<cr>", { desc = "previous buffer", silent = true })
keymap.set("n", "<leader>x", ":bd<cr>", { desc = "remove buffer", silent = true })

-- Smart Splits
keymap.set('n', '<c-h>', smart.move_cursor_left)
keymap.set('n', '<c-j>', smart.move_cursor_down)
keymap.set('n', '<c-k>', smart.move_cursor_up)
keymap.set('n', '<c-l>', smart.move_cursor_right)

-- Copy to system clipboard
keymap.set('v', '<c-y>', '"+y') -- copy selection
keymap.set('n', '<c-y>', '^"+y$') -- copy line, exclude newline/indent

