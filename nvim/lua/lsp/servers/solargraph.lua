local M = {}

local settings = {
    solargraph = {
        definitions = true,
        references = true,
        completion = true,
        diagnostics = true,
    },
}

M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.solargraph.setup {
        on_attach = on_attach,
        settings = settings,
        capabilities = capabilities,
    }
end

return M
