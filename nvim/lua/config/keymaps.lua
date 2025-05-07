vim.g.mapleader = " "

local keymap = vim.keymap
local smart = require("smart-splits")

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
keymap.set('v', '<c-y>', '"+y') -- copy selection
keymap.set('n', '<c-y>', '^"+y$') -- copy line, exclude newline/indent

-- Copilot
keymap.set("n", "<leader>aio", ":CopilotChatOpen<cr>", { desc = "Open Copilot Chat" })
keymap.set("n", "<leader>aic", ":CopilotChatClose<cr>", { desc = "Close Copilot Chat" })

-- Send Text To Wezterm Pane (wip)

-- query stored pane id
-- if stored pane is is bad
-- -- spawn pane
-- -- store pane id

-- send text to pane
-- local spawn_pane = function()
--   local spawn_result = vim.system({'wezterm', 'cli', 'split-pane', '--right'}):wait()
--   vim.g.wezterm_test_pane_id = spawn_result.stdout
-- end
--
-- local send_text = function()
--   vim.system({"echo", "pwd", "|", "wezterm", "cli", "send-text", "--no-paste", "--pane-id", "38" })
-- end
--
-- keymap.set('n', '<leader>wp', spawn_pane, { desc = "Spawn new pane in wezterm"})
-- keymap.set('n', '<leader>wt', send_text, { desc = "Run tests in spawned pane"})
