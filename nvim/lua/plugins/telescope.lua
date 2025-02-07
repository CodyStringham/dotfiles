return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons',                  enabled = false },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      defaults = {
        disable_devicons = true,
        file_ignore_patterns = {
          "cmaps/",
          "*.csv",
          "*.yml",
          "vendor/*"
        }
      },
      pickers = {
        git_status = {
          theme = "ivy"
        },
        buffers = {
          theme = "ivy"
        }
      }
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    local find_files_with = function(opts)
      opts = opts or {}
      return function()
        builtin.find_files(opts)
      end
    end

    local get_selection = function()
      return vim.fn.getregion(
        vim.fn.getpos ".", vim.fn.getpos "v", { mode = vim.fn.mode() }
      )
    end

    vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<C-g>', builtin.git_status, { desc = 'Find Git Status' })
    vim.keymap.set('n', '<C-t>', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<C-.>', builtin.oldfiles, { desc = 'Find Recent' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })

    -- Rails
    vim.keymap.set('n', '<Leader>frm', find_files_with({ cwd = "./app/models" }), { desc = 'Rails Modesl' })
    vim.keymap.set('n', '<Leader>frc', find_files_with({ cwd = "./app/controllers" }), { desc = 'Rails Controllers' })
    vim.keymap.set('n', '<Leader>frv', find_files_with({ cwd = "./app/views" }), { desc = 'Rails Views' })

    -- Find Words
    vim.keymap.set('n', '<C-f>', builtin.grep_string, { desc = "Find current word under cursor"})
    vim.keymap.set('v', '<C-f>', function()
      return builtin.grep_string { default_text = table.concat(get_selection())}
    end, { desc = 'Find word' })
  end
}
