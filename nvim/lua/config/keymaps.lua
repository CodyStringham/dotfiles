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
keymap.set("n", "<leader>yg", function()
  local file_path = vim.fn.system("git ls-files --full-name " .. vim.fn.expand("%")):gsub("\n", "")
  local url = "https://github.com/wrapbook/app/blob/main/" .. file_path
  vim.fn.setreg("+", url)
  print("Yanked: " .. url)
end, { desc = "[y]ank [g]ithub file URL (main)", silent = true })
keymap.set("n", "<leader>yG", function()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
  local file_path = vim.fn.system("git ls-files --full-name " .. vim.fn.expand("%")):gsub("\n", "")
  local url = "https://github.com/wrapbook/app/blob/" .. branch .. "/" .. file_path
  vim.fn.setreg("+", url)
  print("Yanked: " .. url)
end, { desc = "[y]ank [G]ithub file URL (current branch)", silent = true })

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
keymap.set("n", "<leader>ww", nw.rerun_last_cmd, { desc = "[w]ezterm [w] resend last command" })
keymap.set("n", "<leader>wr", function()
  nw.send_text_to_pane("bin/rspec " .. vim.fn.expand("%"))
end, { desc = "Send [w]ezterm cmd [r]spec for current file" })
keymap.set("n", "<leader>wt", function()
  nw.send_text_to_pane("bx rake test TEST=" .. vim.fn.expand("%"))
end, { desc = "Send [w]ezterm cmd mini [t]est for current file" })
keymap.set("n", "<leader>wy", function()
  nw.send_text_to_pane("yarn test " .. vim.fn.expand("%"))
end, { desc = "Send [w]ezterm cmd [y]arn test for current file" })

