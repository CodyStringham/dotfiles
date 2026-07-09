-- Setup
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Theme
config.color_scheme = 'Tokyo Night Moon'
config.font_size = 12
config.harfbuzz_features = { 'calt=1', 'liga=1', 'ss01=1', 'ss02=1', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'ss09=1' }
config.font = wezterm.font('Monaspace Krypton', { weight = 'Medium' })
config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font {
      family = 'Monaspace Krypton',
      weight = 'ExtraBold',
    },
  },
  {
    italic = true,
    font = wezterm.font {
      family = 'Monaspace Radon',
      weight = 'ExtraBold',
      style = 'Italic',
    },
  },
}

config.window_background_gradient = {
  colors = { "#1e2030", "#222436", "#1e2030" },
  orientation = { Linear = { angle = -45.0 } },
}
config.background = {
  {
    source = {
      File = "/Users/cs_wrapbook/dev/dotfiles/wave.jpg"
    },
    opacity = 0.1
  }
}

config.line_height = 1.2

config.window_padding = {
  left = 3,
  right = 3,
  top = 0,
  bottom = 0
}

-- Tabs live inside a session (workspace). Bar hides until a session has >1 tab.
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = "RESIZE"


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
        return win:perform_action({
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
    action = act.SplitPane({
      direction = "Right",
      size = { Percent = 50 }
    })
  },
  {
    key = "_",
    mods = "LEADER|SHIFT",
    action = act.SplitPane({
      direction = "Down",
      size = { Percent = 50 }
    })
  },
  {
    key = "x",
    mods = "LEADER",
    action = act.CloseCurrentPane { confirm = true }
  },
  {
    key = "z",
    mods = "LEADER",
    action = act.TogglePaneZoomState
  },

  -- Sessions (workspaces)
  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      local workspaces = {}
      for _, name in ipairs(wezterm.mux.get_workspace_names()) do
        table.insert(workspaces, { id = name, label = name })
      end
      window:perform_action(
        act.InputSelector {
          title = "Switch workspace",
          choices = workspaces,
          action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
            if id then
              inner_window:perform_action(act.SwitchToWorkspace { name = id }, inner_pane)
            end
          end),
        },
        pane
      )
    end),
  },
  {
    key = "c",
    mods = "LEADER",
    action = act.PromptInputLine {
      description = "New session name:",
      action = wezterm.action_callback(function(window, pane, line)
        if line and line ~= "" then
          window:perform_action(act.SwitchToWorkspace { name = line }, pane)
        end
      end),
    }
  },
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine {
      description = "Rename tab:",
      action = wezterm.action_callback(function(window, _, line)
        if line and line ~= "" then
          window:active_tab():set_title(line)
        end
      end),
    }
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

-- Mux persistence
-- Panes run under wezterm-mux-server (a daemon) instead of the GUI, so
-- quitting/reopening wezterm reattaches to still-running sessions.
config.unix_domains = { { name = 'main' } }
config.default_gui_startup_args = { 'connect', 'main' }

-- Return
return config
