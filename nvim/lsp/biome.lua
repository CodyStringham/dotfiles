return {
  cmd = {
    vim.fn.expand("~/.asdf/shims/npx"),
    "biome",
    "lsp-proxy"
  },
  filetypes = {
    "javascript",
    "typescript",
  },
  root_markers = {
    ".git",
  },
  settings = {
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
