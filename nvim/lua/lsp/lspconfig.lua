return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp"
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "Go to definition"
      keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      opts.desc = "Format file"
      keymap.set("n", "<leader>.", vim.lsp.buf.format, opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- icons
    local signs = { Error = "", Warn = "󰁕", Hint = "󰁕", Info = "●" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- configurations
    lspconfig["ruby_lsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "asdf", "exec", "ruby-lsp" },
      init_options = {
        formatters = { 'standard' },
        linters = { 'standard' }
      }
    })

    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["stimulus_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["standardrb"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      format = { eanble = true },
      indent = { size = 2 },
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } }
        }
      }

    })
  end,
}
