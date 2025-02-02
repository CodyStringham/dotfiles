return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
      },
      vim.api.nvim_create_autocmd({
        "BufWritePre",
      }, {
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end
      })
    })
  end,
}
