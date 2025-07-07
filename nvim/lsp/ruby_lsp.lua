return {
  cmd = {
    vim.fn.expand("~/.asdf/shims/ruby-lsp")
  },
  filetypes = {
    "ruby",
  },
  root_markers = {
    ".git",
  },
  settings = {
    init_options = {
      formatter = "rubocop",
      linters = "rubocop"
    }
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
