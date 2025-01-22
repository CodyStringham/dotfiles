return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  keys = {
    { "<c-p>",     "<cmd>FzfLua files<cr>",      desc = "Search Files" },
    { "<c-t>",     "<cmd>FzfLua buffers<cr>",    desc = "Search Buffers" },
    { "<c-g>",     "<cmd>FzfLua git_status<cr>", desc = "Git Status" },
    { "<leader>f", "<cmd>FzfLua live_grep<cr>",  desc = "Live Search" },
    { "<leader>F", "<cmd>FzfLua grep_cword<cr>", desc = "Search cursor" },
  },
  config = function()
    local fzf_lua = require("fzf-lua")

    fzf_lua.setup({
      winopts = {
        fullscreen = false
      },
      git = {
        icons = {
          ["M"] = { icon = "●", color = "yellow" },
          ["R"] = { icon = "󰁕", color = "yellow" },
          ["D"] = { icon = "", color = "red" },
          ["A"] = { icon = "", color = "green" },
          ["?"] = { icon = "", color = "magenta" },
        }
      },
      file_ignore_patterns = {
        "cmaps/"
      }
    })
  end
}
