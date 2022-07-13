local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
    return
end

treesitter.setup {
    autotag = {
        enable = true,
    },
    ensure_installed = {
      "bash",
      "css",
      "dart",
      "dockerfile",
      "go",
      "gomod",
      "graphql",
      "html",
      "javascript",
      "json",
      "json5",
      "lua",
      "regex",
      "ruby",
      "scss",
      "sql",
      "typescript",
      "vim",
      "vue",
      "yaml",
    },
    highlight = {
        enable = true,
    }
}
