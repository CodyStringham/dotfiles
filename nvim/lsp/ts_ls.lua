return {
  cmd = {
    "/opt/homebrew/bin/typescript-language-server",
    "--stdio"
  },
  filetypes = {
    "javascript",
    "typescript",
  },
  root_markers = {
    "jsconfig.json",
    "tsconfig.json",
    "package.json",
    ".git",
  },
  settings = {
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
