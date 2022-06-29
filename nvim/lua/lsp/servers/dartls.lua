local M = {}

local settings = {
    dartls = {
      closingLabels = true,
      flutterOutline = true,
      onlyAnalyzeProjectsWithOpenFiles = true,
      outline = true,
      suggestFromUnimportedLibraries = true
    },
}

M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.dartls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = settings,
    }
end

return M
