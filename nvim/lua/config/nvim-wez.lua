local M = {}
local wezterm_pane_id = nil
local last_cmd = nil

-- WARN: WIP! Pane must be opened from nvim for each session
-- ---
-- The following improvements can be made!
-- ---
-- set pane_id to inactive pane if tab has two panes
-- set open new pane if we don't have pane_id and tab only has one pane

function M.open_pane_right()
  -- Open a new pane to the right and capture its id
  local cmd = "wezterm cli split-pane --right --percent 50 -- zsh -i"
  local handle = io.popen(cmd)
  local pane_id = ""

  if handle then
    pane_id = vim.trim(handle:read("*a"))
    handle:close()
  end

  if pane_id ~= "" then
    wezterm_pane_id = pane_id
  else
    wezterm_pane_id = nil
  end
end

function M.send_text_to_pane(txt)
  -- send text to split pane
  local pane_id = wezterm_pane_id

  if not pane_id then
    print("No wezterm pane id stored.")
    return
  end

  local cmd_string = 'echo "%s" | wezterm cli send-text --no-paste --pane-id %s'
  local cmd = string.format(cmd_string, txt, pane_id)
  last_cmd = cmd
  os.execute(cmd)
end

function M.rerun_last_cmd()
  os.execute(last_cmd)
end

return M
