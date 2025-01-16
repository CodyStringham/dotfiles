return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<c-p>", "<cmd>FzfLua files<cr>",  desc = "Search Files" },
    { "<c-t>", "<cmd>FzfLua buffers<cr>",    desc = "Search Buffers" },
    { "<c-g>", "<cmd>FzfLua git_status<cr>", desc = "Git Status" },
  },
  config = function()
    local fzf_lua = require("fzf-lua")

    fzf_lua.setup({
      winopts = {
        fullscreen = true
      },
      git = {
        icons = {
          ["M"] = { icon = "●", color = "yellow" },
          ["R"] = { icon = "󰁕", color = "yellow" },
          ["D"] = { icon = "", color = "red" },
          ["A"] = { icon = "", color = "green" },
          ["?"] = { icon = "", color = "magenta" },
        }
      }
    })
  end
}
