return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false, -- wezterm no lazy
    config = function()
      local ss = require("smart-splits")

      ss.setup({
        disable_multiplexer_nav_when_zoomed = false
      })
    end
  }
}
