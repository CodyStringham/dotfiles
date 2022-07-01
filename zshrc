export ZSH=~/.oh-my-zsh
plugins=(git zsh-autosuggestions asdf)
DEFAULT_USER=`whoami`
source $ZSH/oh-my-zsh.sh
ZSH_THEME=""

# Prompt
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -U promptinit; promptinit
prompt pure

# Bat
export BAT_THEME='Nord'

# Editor
export EDITOR='nvim'

# Enable IEx history
# export ERL_AFLAGS="-kernel shell_history enabled"

# Build Path
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/tools/flutter/bin"
export PATH="$PATH:$HOME/tools/lua-language-server/bin"

# GOPATH
# export GOPATH="${HOME}/go"
# export PATH="${PATH}:${GOPATH}/bin"
export GO111MODULE='on'
export GOPRIVATE='gitlab.mx.com'


# CRYSTAL
# export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# JAVAPATH
export JDK_HOME="$HOME/.asdf/installs/java/adoptopenjdk-8.0.332+9"
export JAVA_HOME=${JDK_HOME}
export PATH="$PATH:${JAVA_HOME}"

# Postgres
export PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin"

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_COMMAND='ag -g ""'


# Aliases
alias derp=PB_IGNORE_DEPRECATIONS=1
alias rubytag="ctags -R --languages=ruby --exclude=.git --exclude=log ."
alias k="kubectl"
alias zconfig="vim ~/.zshrc"
alias zreset="source ~/.zshrc"
alias yolo='git reset HEAD --hard && git clean -fd'
alias greset='git checkout master && git pull && git branch --merged | grep -v "\*\|master\|sand\|qa" | xargs -n 1 git branch -d'
alias killdoc='docker stop $(docker ps -a -q)'
alias docup='docker-compose up -d'
alias docdown='docker-compose down'
alias tls='tmux ls'
alias vim="nvim"
alias nats="PB_CLIENT_TYPE=protobuf/nats/client"
alias natserv="nats PB_SERVER_TYPE=protobuf/nats/runner"
alias bx="bundle exec"
alias railsmigrate="bx rails db:migrate && RAILS_ENV=test bx rails db:migrate"
alias railrollback="bx rails db:rollback && RAILS_ENV=test bx rails db:rollback"
alias luamake=/Users/cody/tools/lua-language-server/3rd/luamake/luamake


# Commands
kssh() {pod=`kubectl get pods | grep "$1" | awk '{print $1}' | head -n 1`; kubectl exec -it --request-timeout=5s $pod bash }
kgrep() { k get pods | grep "$1" }
replace() { ag --hidden -l "$1" > /tmp/list; cat /tmp/list; cat /tmp/list | xargs -I{} sed -i "$2" {} ;rm /tmp/list; }
bench() { for i in {1..5}; curl -s -w "%{time_total}\n" -o /dev/null $1 }
lsport() { lsof -i -P -n | grep $1 }
newgemset() { source ~/.rvm/scripts/rvm; rvm --ruby-version use $1@$2 --create }
pullvim() {DIRECTORY_TO_SYNC=~/dev/dotfiles/vim/pack/bundle/start/; for REPO in `ls $DIRECTORY_TO_SYNC`; do (cd "$DIRECTORY_TO_SYNC/$REPO"; echo -e "\x1B[0;31m `pwd` \x1B[0m"; git pull --rebase); done; unset DIRECTORY_TO_SYNC;}
pullnav() {DIRECTORY_TO_SYNC=~/nav/; for REPO in `ls $DIRECTORY_TO_SYNC`; do (cd "$DIRECTORY_TO_SYNC/$REPO"; echo -e "\x1B[0;31m `pwd` \x1B[0m"; git pull --rebase); done; unset DIRECTORY_TO_SYNC;}
trm() { tmux kill-session -t $1 }
tcd() { tmux attach-session -t $1 }
GCO() { git checkout "$(git branch $1 | fzf | tr -d '[:space:]')" }

autoload -U +X bashcompinit && bashcompinit 
autoload -U +X compinit && compinit 

. /usr/local/opt/asdf/libexec/asdf.sh


 #mx teleport start
[ -d "$HOME/.tsh" ] && complete -W "$(cat ~/.tsh/complete*.txt)" ssh
export PATH="$PATH:$HOME/bin" #mx-teleport-bin
tsh status 2>&1 | grep -q EXPIRED && printf "\e[93mYou need to run tlogin\e[0m\n" #mx-teleport-bash-notify
 #mx teleport end
