return {
  'mfussenegger/nvim-lint',
  ft = {
    "ruby",
    "erb",
    'javascript',
    'javascriptreact',
    "vue",
  },
  opts = {
    linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      vue = { 'eslint_d' },
      erb = { 'erb-lint' }
    },
  },
  config = function(_, opts)
    local lint = require('lint')
    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({
      "BufEnter",
      "BufWritePost",
      "InsertLeave",
      "TextChanged",
      "TextChangedI"
    }, {
      callback = function()
        require('lint').try_lint()
        require('lint').try_lint("cspell")
      end
    })
  end,
}
