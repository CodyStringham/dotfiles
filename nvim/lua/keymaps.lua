-- local ok, wk = pcall(require, "which-key")

-- buffers
vim.cmd[[
  nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
  nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
  map <silent> <Leader>x :BD<CR>
]]

-- Telescope
vim.keymap.set('n', '<C-t>', ':Telescope find_files<CR>')
vim.keymap.set('n', '<C-f>', ':Telescope live_grep<CR>')

-- Clear Highlight
vim.keymap.set('n', '<leader>h', ':noh<CR>')

-- NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true})
vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFile<CR>', { noremap = true, silent = true})

-- Vimux
vim.cmd[[ map <expr> <Leader>c ":call VimuxRunCommand('clear; " . input("Command to run: ") . "')<CR>" ]]
vim.keymap.set('n', '<Leader>r',   ':call VimuxRunLastCommand()<CR>')
vim.keymap.set('n', '<Leader>rt',  ':call VimuxRunCommand("clear; bundle exec rails test " . bufname("%"))<CR>')
vim.keymap.set('n', '<Leader>RT',  ':call VimuxRunCommand("clear; bundle exec rails test")<CR>')
vim.keymap.set('n', '<Leader>rs',  ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec " . bufname("%"))<CR>')
vim.keymap.set('n', '<Leader>rsl', ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec " . bufname("%") . ":" . line("."))<CR>')
vim.keymap.set('n', '<Leader>RS',  ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec")<CR>')

-- if not ok then
--     return
-- end
--
-- local opts = {
--     mode = "n",
--     prefix = "",
--     silent = true,
--     noremap = true,
--     nowait = true,
-- }
--
-- wk.register({
--     ["<leader>]"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
--     ["<leader>["] = { "<cmd>bp<cr>", "[BUFFER] Go next buffer" },
--     ["<leader>q"] = { "<cmd>bd<cr>", "[BUFFER] Close current buffer" },
--
--     ["<c-n>"] = { "<cmd>NvimTreeToggle<cr> <cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Toggle" },
--
--     ["<leader>t"] = {
--         name = "[TELESCOPE]",
--         f = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File" },
--         g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by grep" },
--         b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
--         h = { "<cmd>Telescope help_tags<cr>", "[TELESCOPE] Help tags" },
--         m = { "<cmd>Telescope marks<cr>", "[TELESCOPE] Marks" },
--     },
--
--     ["<leader>g"] = {
--         name = "[GITSIGNS]",
--         s = { "<cmd>Gitsigns toggle_signs<cr>", "[GITSIGNS] Toggle signs" },
--         h = { "<cmd>Gitsigns preview_hunk<cr>", "[GITSIGNS] Preview hunk" },
--         d = { "<cmd>Gitsigns diffthis<cr>", "[GITSIGNS] Show diff" },
--     },
-- }, opts)
--
-- wk.setup {}
