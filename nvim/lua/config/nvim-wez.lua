local M = {}
local last_cmd = nil

-- WARN: WIP! Pane must be opened from nvim for each session
-- ---
-- The following improvements can be made!
-- ---
-- set pane_id to inactive pane if tab has two panes
-- set open new pane if we don't have pane_id and tab only has one pane


function M.open_pane(direction)
  -- Open a new pane and capture its id
  local cmd_string = "wezterm cli split-pane --%s --percent 50 -- zsh -i"
  local cmd = string.format(cmd_string, direction)
  local handle = io.popen(cmd)
  local pane_id = ""

  if handle then
    pane_id = vim.trim(handle:read("*a"))
    handle:close()
  end

  if pane_id ~= "" then
    return pane_id
  else
    return nil
  end
end

function M.close_pane(direction)
  -- Close to the direction of current pane
  local pane_id = M.get_pane_id(direction)
  local cmd_string = "wezterm cli kill-pane --pane-id %s"
  local cmd = string.format(cmd_string, pane_id)

  os.execute(cmd)
end

function M.get_pane_id(direction)
  -- Get pane id to the direction of current pane
  local cmd_string = "wezterm cli get-pane-direction %s"
  local cmd = string.format(cmd_string, direction)
  local handle = io.popen(cmd)
  local pane_id = ""

  if handle then
    pane_id = vim.trim(handle:read("*a"))
    handle:close()
  end

  if pane_id ~= "" then
    return pane_id
  else
    return nil
  end
end

function M.send_text_to_pane(txt)
  -- send text to split pane
  local pane_id = M.get_pane_id("right");

  if not pane_id then
    pane_id = M.open_pane("right")
  end

  if not pane_id then
    print("Pane could not be targetted.")
    return;
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
