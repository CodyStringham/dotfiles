vim.g.mapleader = " "

local keymap = vim.keymap
local smart = require("smart-splits")
local nw = require("config.nvim-wez")

-- Search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Clear highlight" })

-- Buffers
keymap.set("n", "<tab>", ":bnext<cr>", { desc = "next buffer", silent = true })
keymap.set("n", "<s-tab>", ":bprevious<cr>", { desc = "previous buffer", silent = true })
keymap.set("n", "<leader>x", ":bp|bd #<cr>", { desc = "remove buffer", silent = true })
keymap.set("n", "<leader>erb", ":silent ! bundle exec erb_lint -a %<cr>", { desc = "format ERB", silent = true })
keymap.set("n", "<leader>scss", ":silent ! yarn stylelint --fix %<cr>", { desc = "format scss", silent = true })

-- Smart Splits
keymap.set('n', '<c-h>', smart.move_cursor_left)
keymap.set('n', '<c-j>', smart.move_cursor_down)
keymap.set('n', '<c-k>', smart.move_cursor_up)
keymap.set('n', '<c-l>', smart.move_cursor_right)

-- Copy to system clipboard
keymap.set('v', '<c-y>', '"+y')   -- copy selection
keymap.set('n', '<c-y>', '^"+y$') -- copy line, exclude newline/indent

-- Wezterm
keymap.set("n", "<leader>wp", nw.open_pane_right, { desc = "Open new [w]ezterm [p]ane" })
keymap.set("n", "<leader>wt", nw.run_rspec_on_current_file, { desc = "Use [w]ezterm pane to run [t]ests" })

-- Copilot
keymap.set("n", "<c-c>", ":CopilotChatToggle<cr>", { desc = "[c]opilot chat toggle" })
keymap.set("n", "<leader>cx", ":CopilotChatReset<cr>", { desc = "[c]opilot chat reset [x]" })
keymap.set('v', '<c-e>', ":CopilotChatExplain<cr>", { desc = "[c]opilot explain selection", noremap = true })
-- NOTE: we have access to the following
-- Explain
-- Review
-- Fix
-- Optimise
-- Docs
-- Tests
-- Commit
