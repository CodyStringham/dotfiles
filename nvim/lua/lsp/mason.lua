return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local mason = require("mason")

      local mason_lspconfig = require("mason-lspconfig")

      mason.setup()

      mason_lspconfig.setup({
        ensure_installed = {
          "html",
          "lua_ls",
          "ruby_lsp",
          "standardrb",
          "stimulus_ls",
          "tailwindcss"
        },
        automatic_installation = true,
      })
    end
  }
}
