export ZSH=~/.oh-my-zsh
plugins=(git rvm zsh-autosuggestions)
ZSH_THEME="agnoster"
DEFAULT_USER=`whoami`
source $ZSH/oh-my-zsh.sh
source $HOME/.rvm/scripts/rvm
eval $(thefuck --alias)


# Aliases
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias k="kubectl"
alias zconfig="vim ~/.zshrc"
alias birdy="source .env && iex -S mix phx.server"
alias powo="powder open"
alias powr="powder restart"
alias powlink="ln -s ~/.powenv .powenv"
alias pumarestart="pkill -USR1 puma-dev"
alias yolo='git reset HEAD --hard && git clean -f -d'
alias wipebranches='git branch | grep -ve " master$" | xargs git branch -D'
alias killdoc='docker stop $(docker ps -a -q)'
alias tls='tmux ls'
trm() { tmux kill-session -t $1 }
tcd() { tmux attach-session -t $1 }

alias merges='echo "git checkout stage && git pull --rebase && git merge master && git push && git checkout master" && git checkout stage && git pull --rebase && git merge master && git push && git checkout master'
alias mergep='echo "git checkout production && git pull --rebase && git merge master && git push && git checkout master" && git checkout production && git pull --rebase && git merge master && git push && git checkout master'

# Nav
# Must do this before shutting down computer
alias navdown="nav stop allosaurus; nav stop medusa; nav stop nav_web; nav stop zuul; nav stop lexcorp; nav stop core"
# Run after update
alias navsetup="nav setup medusa; nav start medusa; nav setup allosaurus; nav stop medusa; nav setup nav_web; nav setup zuul; nav setup lexcorp; nav setup core"
# After starting computer
alias navup="nav start allosaurus --no-mount; nav start nav_web; nav start zuul; nav start lexcorp; nav start core"
# Update master on all dependencies
alias navupdate="nav update allosaurus; nav update medusa; nav update nav_web; nav update zuul; nav update lexcorp; nav update core"
# Troubleshooting option if something isn't working; probably unnecessary
alias navrestart="nav restart allosaurus; nav restart nav_web; nav restart zuul; nav restart lexcorp; nav restart core"


# Commands
serv() { ruby -run -e httpd -- . -p $1 }
sshnav() { ssh -i ~/.ssh/id_rsa deploy@$1 }
bench() { for i in {1..5}; curl -s -w "%{time_total}\n" -o /dev/null $1 }
newgemset() { source ~/.rvm/scripts/rvm; rvm --ruby-version use $1@$2 --create }
pullvim() {DIRECTORY_TO_SYNC=~/dev/dotfiles/vim/pack/bundle/start/; for REPO in `ls $DIRECTORY_TO_SYNC`; do (cd "$DIRECTORY_TO_SYNC/$REPO"; echo -e "\x1B[0;31m `pwd` \x1B[0m"; git pull --rebase); done; unset DIRECTORY_TO_SYNC;}
pullnav() {DIRECTORY_TO_SYNC=~/nav/; for REPO in `ls $DIRECTORY_TO_SYNC`; do (cd "$DIRECTORY_TO_SYNC/$REPO"; echo -e "\x1B[0;31m `pwd` \x1B[0m"; git pull --rebase); done; unset DIRECTORY_TO_SYNC;}
sizeaccess() {DIRECTORY_TO_SYNC=~/dev/access/; for REPO in `ls $DIRECTORY_TO_SYNC`; do (cd "$DIRECTORY_TO_SYNC/$REPO"; echo -e "\x1B[0;31m `pwd` \x1B[0m"; du -hs); done; unset DIRECTORY_TO_SYNC;}
cleanaccess() {DIRECTORY_TO_SYNC=~/dev/access/; for REPO in `ls $DIRECTORY_TO_SYNC`; do (cd "$DIRECTORY_TO_SYNC/$REPO"; echo -e "\x1B[0;31m `pwd` \x1B[0m"; git gc --prune=all --aggressive); done; unset DIRECTORY_TO_SYNC;}

export EDITOR='nvim -w'

# Enable IEx history
export ERL_AFLAGS="-kernel shell_history enabled"

# Paths
export PATH="$PATH:$HOME/.asdf:/usr/local/bin:/usr/bin:/bin"

# GOPATH
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"

# JAVAPATH
#export JAVA_HOME="/Library/Java/Home"

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
