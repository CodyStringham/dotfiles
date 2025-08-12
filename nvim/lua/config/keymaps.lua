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
keymap.set("n", "<leader>yf", ":let @+=expand('%:p')<cr>", { desc = "[y]ank current [f]ile path", silent = true })

-- Smart Splits
keymap.set('n', '<c-h>', smart.move_cursor_left)
keymap.set('n', '<c-j>', smart.move_cursor_down)
keymap.set('n', '<c-k>', smart.move_cursor_up)
keymap.set('n', '<c-l>', smart.move_cursor_right)

-- Copy to system clipboard
keymap.set('v', '<c-y>', '"+y')   -- copy selection
keymap.set('n', '<c-y>', '^"+y$') -- copy line, exclude newline/indent

-- Wezterm
keymap.set("n", "<leader>ww", nw.rerun_last_cmd, { desc = "[w]ezterm [w] resend last command" })

keymap.set("n", "<leader>wcl", function()
  nw.close_pane("right")
end, { desc = "Open new [w]ezterm [c]lose pane right" })
keymap.set("n", "<leader>wcj", function()
  nw.close_pane("down")
end, { desc = "Open new [w]ezterm [c]lose pane down" })
keymap.set("n", "<leader>wck", function()
  nw.close_pane("up")
end, { desc = "Open new [w]ezterm [c]lose pane up" })
keymap.set("n", "<leader>wch", function()
  nw.close_pane("left")
end, { desc = "Open new [w]ezterm [c]lose pane left" })

keymap.set("n", "<leader>wr", function()
  nw.send_text_to_pane("bin/rspec " .. vim.fn.expand("%"))
end, { desc = "Send [w]ezterm cmd [r]spec for current file" })
keymap.set("n", "<leader>wt", function()
  nw.send_text_to_pane("bx rake test TEST=" .. vim.fn.expand("%"))
end, { desc = "Send [w]ezterm cmd mini [t]est for current file" })
keymap.set("n", "<leader>wy", function()
  nw.send_text_to_pane("yarn test " .. vim.fn.expand("%"))
end, { desc = "Send [w]ezterm cmd [y]arn test for current file" })


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
