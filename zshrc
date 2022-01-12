export ZSH=~/.oh-my-zsh
plugins=(git zsh-autosuggestions asdf)
DEFAULT_USER=`whoami`
source $ZSH/oh-my-zsh.sh
ZSH_THEME=""

# Prompt
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

# GOPATH
# export GOPATH="${HOME}/go"
# export PATH="${PATH}:${GOPATH}/bin"

# CRYSTAL
# export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# JAVAPATH
export JDK_HOME="/Users/cody.stringham/.asdf/installs/java/liberica-1.8.0"
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
alias gocs="cd ~/go/src/github.com/codystringham"
alias gonav="cd ~/go/src/git.nav.com/backend"
alias k="kubectl"
alias zconfig="vim ~/.zshrc"
alias zreset="source ~/.zshrc"
alias yolo='git reset HEAD --hard && git clean -f -d'
alias wipebranches='git branch | grep -ve " master$" | xargs git branch -D'
alias killdoc='docker stop $(docker ps -a -q)'
alias docup='docker-compose up -d'
alias docdown='docker-compose down'
alias tls='tmux ls'
alias merges='echo "git checkout stage && git pull --rebase && git merge master && git push && git checkout master" && git checkout stage && git pull --rebase && git merge master && git push && git checkout master'
alias mergep='echo "git checkout production && git pull --rebase && git merge master && git push && git checkout master" && git checkout production && git pull --rebase && git merge master && git push && git checkout master'
alias nsqstart='nsqlookupd & nsqd --lookupd-tcp-address=127.0.0.1:4160 & nsqadmin --lookupd-http-address=127.0.0.1:4161 &'
alias vim="nvim"
alias nats="PB_CLIENT_TYPE=protobuf/nats/client"
alias natserv="nats PB_SERVER_TYPE=protobuf/nats/runner"
alias bx="bundle exec"


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

autoload -U +X bashcompinit && bashcompinit 
autoload -U +X compinit && compinit 
complete -W "$(cat ~/.tsh/complete*.txt)" ssh #mx-teleport-bash-complete

tsh status 2>&1 | grep -q EXPIRED && printf "\e[93mYou need to run tlogin\e[0m\n" #mx-teleport-bash-notify

export PATH="$PATH:$HOME/bin" #mx-teleport-bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source ~/.rvm/scripts/rvm
