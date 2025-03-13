export ZSH="$HOME/.oh-my-zsh"
plugins=(git asdf)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR='nvim'

# Build Path
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"


# GOPATH
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"

# Postgres
export PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin"

#FZF
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='rg -g ""'

#FC TESTS
export PARALLEL_WORKERS=8

# Aliases
alias yolo='git reset HEAD --hard && git clean -fd'
alias bx="bundle exec"
alias lsplog="tail -f ~/.local/state/nvim/lsp.log"
alias lg="lazygit"
alias nv="nvim"
alias ls="eza --color=always --long --no-filesize --icons=auto --no-time --no-user --no-permissions"
alias lsa="eza --color=always --long --icons=auto"
alias headful="RSPEC_CAPYBARA_DRIVER=selenium_chrome rspec"


# Commands
GCO() { git checkout "$(git branch $1 | fzf | tr -d '[:space:]')" }
cap () { tee /tmp/capture.out; } # capture the output of a command
ret () { cat /tmp/capture.out; } # return the most recent command that was captured
rtest () { bx rake test TEST=$1 }

# autosuggestions
. /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
. /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide
eval "$(zoxide init zsh)"

# asdf
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# ohmyposh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/dev/dotfiles/prompt.omp.json)"
fi
