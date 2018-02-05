new-window
rename-window Config
send-keys "cd dev/dotfiles" Enter
send-keys "nvim ." Enter
kill-window -t 0
new-window
rename-window Project
split-window -h
resize-pane -R 30
selectp -L
