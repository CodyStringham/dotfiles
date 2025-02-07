return {
  'mfussenegger/nvim-lint',
  ft = {
    "ruby",
    "erb",
    'javascript',
    'javascriptreact',
    "vue",
  },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      vue = { 'eslint_d' },
      erb = { 'erb-lint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({
      "BufEnter",
      "BufWritePost",
      "InsertLeave",
    }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
        lint.try_lint("cspell")
      end
    })
  end,
}
