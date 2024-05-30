export ZSH=~/.oh-my-zsh
plugins=(git asdf)
DEFAULT_USER=`whoami`
source $ZSH/oh-my-zsh.sh
ZSH_THEME=""

# Bat
export BAT_THEME='Nord'

# Editor
export EDITOR='vim'

# Build Path
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/tools/flutter/bin"
export PATH="$PATH:$HOME/tools/lua-language-server/bin"

# GOPATH
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"

# CRYSTAL
# export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# JAVAPATH
# export JDK_HOME="$HOME/.asdf/installs/java/adoptopenjdk-8.0.332+9"
# export JAVA_HOME=${JDK_HOME}
# export PATH="$PATH:${JAVA_HOME}"

# Postgres
export PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin"

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_COMMAND='ag -g ""'

#FC TESTS
export PARALLEL_WORKERS=8

# Aliases
alias k="kubectl"
alias yolo='git reset HEAD --hard && git clean -fd'
alias tls='tmux ls'
alias bx="bundle exec"
alias dbstatus="bx rails db:migrate:status"
alias dbmigrate="bx rails db:migrate && RAILS_ENV=test bx rails db:migrate"
alias dbrollback="bx rails db:rollback && RAILS_ENV=test bx rails db:rollback"
alias luamake=/Users/cody/tools/lua-language-server/3rd/luamake/luamake


# Commands
kssh() {pod=`kubectl get pods | grep "$1" | awk '{print $1}' | head -n 1`; kubectl exec -it --request-timeout=5s $pod bash }
kgrep() { k get pods | grep "$1" }
trm() { tmux kill-session -t $1 }
tcd() { tmux attach-session -t $1 }
GCO() { git checkout "$(git branch $1 | fzf | tr -d '[:space:]')" }
cap () { tee /tmp/capture.out; } # capture the output of a command so it can be retrieved with ret
ret () { cat /tmp/capture.out; } # return the output of the most recent command that was captured by cap

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# autosuggestions
. /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
