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

      opts.desc = "Go to references"
      keymap.set("n", "gr", vim.lsp.buf.references, opts)

      opts.desc = "Format file"
      keymap.set("n", "<leader>.", vim.lsp.buf.format, opts)

      opts.desc = "Rename variable under cursor"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Execute a code action"
      keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

      -- Find references for the word under your cursor.
      -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

      -- Fuzzy find all the symbols in your current workspace.
      --  Similar to document symbols, except searches over your entire project.
      -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
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
      filetypes = { "ruby", "eruby" },
      cmd = { "asdf", "exec", "ruby-lsp" },
      init_options = {
        formatters = { 'standard' },
        linters = { 'standard' }
      }
    })

    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "haml", "eruby" }
    })

    lspconfig["standardrb"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "ruby", "eruby" }
    })

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["volar"].setup({
      capabilities = capabilities,
      on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      filetypes = { 'vue' }
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      format = { eanble = true },
      indent = { size = 2 },
      filetypes = { "lua" },
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } }
        }
      }

    })
  end,
}
