export ZSH=~/.oh-my-zsh
plugins=(git zsh-autosuggestions)
DEFAULT_USER=`whoami`
source $ZSH/oh-my-zsh.sh
eval $(thefuck --alias)
ZSH_THEME=""

# Prompt
autoload -U promptinit && promptinit
prompt filthy

# Editor
export EDITOR='nvim -w'

# Enable IEx history
export ERL_AFLAGS="-kernel shell_history enabled"

# Build Path
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/local/sbin"

# GOPATH
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"

# CRYSTAL
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# JAVAPATH
#export JAVA_HOME="/Library/Java/Home"
#

# Postgres
export PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin"

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'


# Aliases
alias vim="nvim"
alias vi="nvim"
alias v="nvim ."
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


# Nav
alias allosaurus="cd ~/nav/allosaurus"
alias batcave="cd ~/nav/batcave"
alias rp="cd ~/nav/relevant_paths"
alias voltron="cd ~/nav/voltron"
alias pudge="gonav && cd pudge"
alias exp="gonav && cd experian_personal_alerts"
alias workers="gonav && cd go_pudge_workers"
alias int1="kubectl config use-context int1"
alias int2="kubectl config use-context int2"
alias int3="kubectl config use-context int3"
alias staging="kubectl config use-context staging"
alias sandbox="kubectl config use-context sandbox"
alias demo="kubectl config use-context demo"
alias prod="kubectl config use-context prod"
alias convey="$GOPATH/bin/goconvey"


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


. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
