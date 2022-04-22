local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug('neovim/nvim-lspconfig')
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug('/usr/local/opt/fzf')
  Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
  Plug('junegunn/fzf.vim')
  Plug('scrooloose/nerdtree')
  Plug('JamshedVesuna/vim-markdown-preview')
  Plug('christoomey/vim-tmux-navigator')
  Plug('benmills/vimux')
  Plug('airblade/vim-gitgutter')
  Plug('tpope/vim-fugitive')
  Plug('arcticicestudio/nord-vim')
  Plug('vim-airline/vim-airline')
  Plug('ryanoasis/vim-devicons')
  Plug('tpope/vim-commentary')
  Plug('tpope/vim-sensible')
  Plug('tpope/vim-bundler')
  Plug('tpope/vim-rails')
  Plug('vim-ruby/vim-ruby')
  Plug('Raimondi/delimitMate')
  Plug('Yggdroot/indentLine')
  Plug('qpkorr/vim-bufkill')
  Plug('sheerun/vim-polyglot')
vim.call('plug#end')

-- Airline
vim.g['g:airline_powerline_fonts'] = 1
vim.g['airline_extensions'] = {}

-- DelimitMate
vim.g['delimitMate_expand_cr'] = 1

-- FZF
vim.cmd[[ set rtp+=/usr/local/opt/fzf ]]
vim.keymap.set('n', '<C-t>', ':Files<CR>', { noremap = true, silent = true})

-- Indent
vim.g['indentLine_char'] = '┆'
vim.g['vim_json_syntax_conceal'] = 0

-- LSP
require'lspconfig'.solargraph.setup{}

-- Nerd Tree
vim.g['NERDTreeDirArrowExpandable'] = '→'
vim.g['NERDTreeDirArrowCollapsible'] = '↓'
vim.g['NERDTreeShowHidden'] = 1
vim.g['NERDTreeMouseMode'] = 3
vim.g['NERDTreeQuitOnOpen'] = 1
vim.g['NERDTreeAutoDeleteBuffer'] = 1
vim.g['NERDTreeMinimalUI'] = 1
vim.g['NERDTreeDirArrows'] = 1
vim.cmd [[ autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif ]]
vim.keymap.set('n', '<Leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true})
vim.keymap.set('n', '<Leader>m', ':NERDTreeFind<CR>', { noremap = true, silent = true})

-- nvim-cmp
vim.cmd[[ set completeopt=menu,menuone,noselect ]]
local cmp = require'cmp'
-- Global setup.
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'snippy' }, -- For snippy users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
  })
})
-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- require('lspconfig')[%YOUR_LSP_SERVER%].setup {
  -- capabilities = capabilities
-- }

-- Vimux
vim.cmd[[ map <expr> <Leader>c ":call VimuxRunCommand('clear; " . input("Command to run: ") . "')<CR>" ]]
vim.keymap.set('n', '<Leader>r', ':call VimuxRunLastCommand()<CR>')
vim.keymap.set('n', '<Leader>rt', ':call VimuxRunCommand("clear; bundle exec rails test " . bufname("%"))<CR>')
vim.keymap.set('n', '<Leader>RT', ':call VimuxRunCommand("clear; bundle exec rails test")<CR>')
vim.keymap.set('n', '<Leader>rs', ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec " . bufname("%"))<CR>')
vim.keymap.set('n', '<Leader>rsl', ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec " . bufname("%") . ":" . line("."))<CR>')
vim.keymap.set('n', '<Leader>RS', ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec")<CR>')
