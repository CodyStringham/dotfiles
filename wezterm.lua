-- Setup
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Configs
config.color_scheme = 'nightfox'
config.font = wezterm.font_with_fallback {
  'Monaspace Krypton',
  'Monaspace Neon'
}

-- Smart Splits
local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),

  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitPane({
      direction = "Right",
      size = { Percent = 50 }
    })
  },
  {
    key = "_",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitPane({
      direction = "Down",
      size = { Percent = 50 }
    })
  },
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane { confirm = true }
  },
  {
    key = "z",
    mods = "LEADER",
    action = wezterm.action.TogglePaneZoomState
  },
}

config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
}

-- Return
return config
