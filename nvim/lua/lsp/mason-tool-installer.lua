return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  config = function()
    local mason_tools = require("mason-tool-installer")

    mason_tools.setup({
      ensure_installed = {
        'biome',
        'eslint_d',
        'prettierd',
        'erb-lint',
        'cspell'
      },
    })
  end
}
