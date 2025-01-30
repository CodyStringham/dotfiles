export ZSH="$HOME/.oh-my-zsh"
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DOCKER_COMPOSE_SHOW=false
SPACESHIP_KUBECTL_SHOW=false
ZSH_THEME="spaceship"

plugins=(git asdf)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR='nvim'

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

# Postgres
export PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin"

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_COMMAND='ag -g ""'

#FC TESTS
export PARALLEL_WORKERS=8

# Aliases
alias yolo='git reset HEAD --hard && git clean -fd'
alias bx="bundle exec"
alias dbstatus="bx rails db:migrate:status"
alias dbmigrate="bx rails db:migrate && RAILS_ENV=test bx rails db:migrate"
alias dbrollback="bx rails db:rollback && RAILS_ENV=test bx rails db:rollback"
alias luamake=/Users/cody/tools/lua-language-server/3rd/luamake/luamake
alias lsplog="tail -f ~/.local/state/nvim/lsp.log"
alias lg="lazygit"


# Commands
kssh() {pod=`kubectl get pods | grep "$1" | awk '{print $1}' | head -n 1`; kubectl exec -it --request-timeout=5s $pod bash }
kgrep() { k get pods | grep "$1" }
trm() { tmux kill-session -t $1 }
tcd() { tmux attach-session -t $1 }
GCO() { git checkout "$(git branch $1 | fzf | tr -d '[:space:]')" }
cap () { tee /tmp/capture.out; } # capture the output of a command so it can be retrieved with ret
ret () { cat /tmp/capture.out; } # return the output of the most recent command that was captured by cap
rtest () { bx rake test TEST=$1 }

function fcstaging {
  ##
  # Configurables
  # download_directory: Represents the folder your .tar file is downloaded in
  #
  download_directory=${HOME}/Downloads

  fcstaging_directory=${TMPDIR}/fcstaging
  echo "File is set to be located at $download_directory"
  echo "Here is the list of .tar files located at $download_directory"
  ls -lh $download_directory | grep '[a-z|0-9\-]*\.tar$'
  echo ""
  echo "------------------------------------------------------------------------------"
  echo "Enter filename of downloaded staging .tar file below (include .tar at the end)"
  read TARFILE
  if ! [ -r "$download_directory/${TARFILE}" ]
  then
    echo "Exiting... File not found"
    return 0
  fi
  mkdir -p $fcstaging_directory
  echo "Uncompressing $TARFILE file"
  tar -xf ${download_directory}/${TARFILE} -C $fcstaging_directory
  echo "Deleting old local staging database"
  psql -a -c "DROP DATABASE lim_db_1;"
  echo "Restoring staging database locally"
  pg_restore --verbose --dbname postgres --create --clean --jobs 8 $fcstaging_directory
  echo "Cleaning up tmp files"
  rm -rf $fcstaging_directory
  echo "Done"
}

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# autosuggestions
. /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
