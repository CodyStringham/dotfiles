# Mouse stuff
set -g mouse on

set-option -g default-shell /bin/zsh

set-option -g status-bg '#666666'
set-option -g status-fg '#ffffff'

set-option -g status-left-length 50
set-option -g status-right "Pane #P |  #(date '+%a, %b %d - %I:%M') "
set-option -g allow-rename off

set-window-option -g clock-mode-style 12

# Escape now!
set -sg escape-time 0

#source-file "${HOME}/dev/dotfiles/.tmux-themepack/powerline/default/yellow.tmuxtheme"
source-file "${HOME}/dev/dotfiles/tmux-themepack/powerline/default/cyan.tmuxtheme"

# Fine adjustment (1 or 2 cursor cells per bump)
bind -n S-Left resize-pane -L 2
bind -n S-Right resize-pane -R 2
bind -n S-Down resize-pane -D 1
bind -n S-Up resize-pane -U 1

# Better splits
unbind %
bind | split-window -h -c '#{pane_current_path}'
bind _ split-window -v -c '#{pane_current_path}'

# Tab window change
bind Tab next-window

# Reload!
bind r source-file ~/dev/dotfiles/tmux \; display-message " ✱ tmux.conf is reloaded"

# Start new tmux for dev
bind P source-file ~/dev/dotfiles/dev.tmux

set -g status-left '#{?client_prefix,#[fg=yellow]tmux prefix ..,[#S]}'

# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"
bind-key -T copy-mode-vi C-h select-pane -L
bind-key -T copy-mode-vi C-j select-pane -D
bind-key -T copy-mode-vi C-k select-pane -U
bind-key -T copy-mode-vi C-l select-pane -R
bind-key -T copy-mode-vi C-\ select-pane -l


# Add truecolor support
set-option -ga terminal-overrides ",xterm-256color:Tc"
# Default terminal is 256 colors
set -g default-terminal "screen-256color"
