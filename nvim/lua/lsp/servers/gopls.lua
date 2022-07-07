local M = {}

local settings = {
  gopls = {
    analyses = {
      unusedparams = true,
    },
    staticcheck = true,
  }
}

M.setup = function(on_attach, capabilities)
  local lspconfig = require "lspconfig"

  lspconfig.gopls.setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = settings,
    capabilities = capabilities,
  }
end

return M
