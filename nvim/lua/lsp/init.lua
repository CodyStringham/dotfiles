local utils = require "utils"

-- local servers = {
--     "bashls",
--     "sumneko_lua",
--     "cssls",
--     "html",
--     "jsonls",
--     "yamlls",
--     "dockerls",
--     "sumneko_lua",
--     "gopls",
-- }

local servers = {
  "solargraph",
}

-- Floating border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or { { " ", "FloatBorder" } }
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local opts = { noremap = true, silent = true, nowait = true }

vim.api.nvim_set_keymap("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>en", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>fmt", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local had_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if had_cmp_nvim_lsp then
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
end

local had_lspconfig = pcall(require, "lspconfig")
if had_lspconfig then
    for _, server in ipairs(servers) do
        require("lsp.servers." .. server).setup(on_attach, capabilities)
    end
end

-- Gutter sign icons
for type, icon in pairs(utils.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Prefix diagnostic virtual text
vim.diagnostic.config {
    virtual_text = {
        source = "always",
        prefix = " ",
        spacing = 6,
    },
    float = {
        header = false,
        source = "always",
    },
    signs = true,
    underline = false,
    update_in_insert = false,
}
