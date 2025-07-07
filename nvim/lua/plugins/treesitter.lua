return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = { "windwp/nvim-ts-autotag" },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "yaml",
        "html",
        "css",
        "scss",
        "embedded_template",
        "markdown",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "ruby",
        "vue"
      }
    })
  end
}
