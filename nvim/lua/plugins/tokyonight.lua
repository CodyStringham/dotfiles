return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent"
      },
      on_highlights = function(hl, c)
        hl.Comment = { fg = c.comment, bold = false, italic = false }
      end,
    }
    vim.cmd('colorscheme tokyonight-moon')
  end
}
