local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug('neovim/nvim-lspconfig')

  Plug('hrsh7th/cmp-nvim-lsp')
  Plug('hrsh7th/cmp-buffer')
  Plug('hrsh7th/cmp-path')
  Plug('hrsh7th/cmp-cmdline')
  Plug('hrsh7th/nvim-cmp')
  Plug('hrsh7th/vim-vsnip')
  Plug('hrsh7th/vim-vsnip-integ')

  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug('akinsho/bufferline.nvim', {['tag'] = 'v2.*' })
  Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})
  Plug('nvim-lualine/lualine.nvim')
  Plug('rmehri01/onenord.nvim', {['branch'] = 'main' })

  Plug('/usr/local/opt/fzf')
  Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
  Plug('junegunn/fzf.vim')

  Plug('benmills/vimux')
  Plug('christoomey/vim-tmux-navigator')

  Plug('JamshedVesuna/vim-markdown-preview')
  Plug('airblade/vim-gitgutter')
  Plug('tpope/vim-fugitive')
  Plug('tpope/vim-commentary')
  Plug('tpope/vim-sensible')
  Plug('tpope/vim-bundler')
  Plug('tpope/vim-rails')
  Plug('Raimondi/delimitMate')
  Plug('Yggdroot/indentLine')
  Plug('qpkorr/vim-bufkill')

  Plug('cocopon/iceberg.vim')
  Plug('drewtempelmeyer/palenight.vim')
  Plug('michaeldyrynda/carbon')
vim.call('plug#end')


-- One Nord
require('onenord').setup()


-- Lualine
require('lualine').setup {
  options = {
    theme = 'onenord',
    section_separators = { left = '', right = '' },
    component_separators = { left = '|', right = '|' }
  }
}


-- Bufferline
require('bufferline').setup {
  options = {
    diagnostics = "nvim_lsp",
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      }
    }
  }
}


-- DelimitMate
vim.g['delimitMate_expand_cr'] = 1


-- FZF
vim.cmd[[ set rtp+=/usr/local/opt/fzf ]]
vim.keymap.set('n', '<C-t>', ':Files<CR>', { noremap = true, silent = true})


-- Indent
vim.g['indentLine_char'] = '┆'
vim.g['vim_json_syntax_conceal'] = 0


-- LSP
lspconfig = require('lspconfig')
lspconfig.gopls.setup{}
lspconfig.solargraph.setup{
  settings = {
    solargraph = {
      definitions = true,
      references = true,
      completion = true,
      diagnostics = true,
    }
  }
}

vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gf', '<Cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<Leader>fmt', '<cmd>lua vim.lsp.buf.formatting()<CR>')


-- Nvim-cmp
vim.cmd[[ set completeopt=menu,menuone,noselect ]]
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
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
  }, {
    { name = 'buffer' },
  })
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
require('lspconfig')['solargraph'].setup {
  capabilities = capabilities
}
require('lspconfig')['gopls'].setup {
  capabilities = capabilities
}


-- Nvim Devicons
require('nvim-web-devicons').setup()

-- Nvim Tree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true})
vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFile<CR>', { noremap = true, silent = true})
require('nvim-tree').setup {
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        { key = "<C-t>", action = "" },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = true,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}


-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "ruby", "go", "proto", "html", "json", "lua", "javascript" },
  sync_install = true,
}


-- Vimux
vim.cmd[[ map <expr> <Leader>c ":call VimuxRunCommand('clear; " . input("Command to run: ") . "')<CR>" ]]
vim.keymap.set('n', '<Leader>r', ':call VimuxRunLastCommand()<CR>')
vim.keymap.set('n', '<Leader>rt', ':call VimuxRunCommand("clear; bundle exec rails test " . bufname("%"))<CR>')
vim.keymap.set('n', '<Leader>RT', ':call VimuxRunCommand("clear; bundle exec rails test")<CR>')
vim.keymap.set('n', '<Leader>rs', ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec " . bufname("%"))<CR>')
vim.keymap.set('n', '<Leader>rsl', ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec " . bufname("%") . ":" . line("."))<CR>')
vim.keymap.set('n', '<Leader>RS', ':call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec")<CR>')
