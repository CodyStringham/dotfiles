return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false,   -- make sure we load this during startup if it is your main colorscheme
  priority = 999, -- make sure to load this before all the other start plugins
  branch = "v3.x",
  keys = {
    { "<c-\\>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
  },
  config = function()
    local neotree = require("neo-tree")

    neotree.setup({
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added     = "",
            deleted   = "",
            modified  = "●",
            renamed   = "󰁕",
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          }
        }
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      event_handlers = {
        {
          event = "file_open_requested",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end
        },

      }
    })
  end
}
