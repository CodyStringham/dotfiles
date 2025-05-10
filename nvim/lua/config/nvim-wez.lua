local M = {}
local wezterm_pane_id = nil

-- WARN: WIP! Pane must be opened from nvim for each session
-- ---
-- The following improvements can be made!
-- ---
-- set pane_id to inactive pane if tab has two panes
-- set open new pane if we don't have pane_id and tab only has one pane

function M.open_pane_right()
  -- Open a new pane to the right and capture its id
  local cmd = "wezterm cli split-pane --right --percent 50 -- zsh -i"
  os.execute(cmd)
  -- Get the most recently created pane id
  local handle = io.popen("wezterm cli list --format json")
  local result = handle and handle:read("*a") or ""
  if handle then handle:close() end
  local panes = vim.fn.json_decode(result)
  wezterm_pane_id = panes[#panes] and panes[#panes].pane_id or nil
end

function M.get_pane_id()
  return wezterm_pane_id or vim.g.wezterm_pane_id
end

function M.run_rspec_on_current_file()
  local pane_id = M.get_pane_id()
  if not pane_id then
    print("No wezterm pane id stored.")
    return
  end
  local cmd = string.format('echo "bin/rspec %s" | wezterm cli send-text --no-paste --pane-id %s', vim.fn.expand('%'), pane_id)
  os.execute(cmd)
end

return M
