return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = false,
    message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
    date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
    virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    gitblame_schedule_event = "CursorHold",
    gitblame_clear_event = "CursorHoldI",
    gitblame_delay = 3000
  },

  keys = {
    { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
  }

}
