return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local git_signs = require("gitsigns")

    git_signs.setup({
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    })
  end
}
