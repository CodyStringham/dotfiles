 ZSH="$HOME/.oh-my-zsh"
plugins=(git asdf)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR='nvim'

# Build Path
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/.local/bin"
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

#WB TESTS
export COVERAGE=true

# Aliases
alias yolo='git reset HEAD --hard && git clean -fd'
alias bx="bundle exec"
alias lsplog="tail -f ~/.local/state/nvim/lsp.log"
alias lg="lazygit"
alias nv="nvim"
alias ls="eza --color=always --long --no-filesize --icons=auto --no-time --no-user --no-permissions"
alias lsa="eza --color=always --long --icons=auto"
alias headful="RSPEC_CAPYBARA_DRIVER=selenium_chrome"
alias pullmain="git pull --rebase && bundle && yarn install && bin/rails db:migrate && yolo"
alias mind="overmind start -F ~/overmind.tmux.conf -l web,vite,rails"
alias mindful="overmind start -F ~/overmind.tmux.conf"
alias jsreset="bin/rails assets:clobber && rm -rf node_modules && yarn install"
alias opus="claude --model claude-opus-4-8"
alias fable="claude --model claude-opus-4-8"

# Commands
GCO() { git checkout "$(git branch $1 | fzf | tr -d '[:space:]')" }
# Fuzzy cd into a git worktree of the current repo (includes the main checkout)
CDW() {
  local dir=$(git worktree list | fzf --height=40% --reverse | awk '{print $1}')
  [[ -n "$dir" ]] && cd "$dir"
}
cap () { tee /tmp/capture.out; } # capture the output of a command
ret () { cat /tmp/capture.out; } # return the most recent command that was captured
rtest () { bx rake test TEST=$1 }
unstack() {
  local branch=$(git branch --show-current)
  local remote=$(git config branch.$branch.remote)
  local merge=$(git config branch.$branch.merge | sed 's|refs/heads/||')
  git fetch origin
  git rebase --onto origin/main $remote/$merge
}

# New wezterm session running claude in a worktree, based on the branch you invoke from.
# Run from main for a main-based worktree, or from a feature worktree to stack on it.
# Usage: weztree cs/FE-3001/bulk-toolbar
weztree() {
  local origin="$PWD"
  local name="$*"
  [[ -z "$name" ]] && read -r "name?worktree session name: "
  [[ -z "$name" ]] && { echo "weztree: name required" >&2; return 1; }
  local slug=$(printf '%s' "$name" | tr -cs 'A-Za-z0-9._-' '-' | sed 's/^-//; s/-$//')
  local root="$HOME/dev/wrapbook/app"
  local wt="$root/.claude/worktrees/$slug"
  local pane=$(wezterm cli spawn --new-window --workspace "$name" \
    --cwd "$origin" -- \
    zsh -lc "LEFTHOOK=0 claude --model claude-opus-4-8 --worktree $slug; exec zsh") || return 1
  wezterm cli split-pane --pane-id "$pane" --bottom --percent 30 \
    --cwd "$root" -- \
    zsh -lc "for i in {1..200}; do [ -e '$wt/.git' ] && [ \"\$(git -C '$wt' branch --show-current 2>/dev/null)\" = 'worktree-$slug' ] && break; sleep 0.3; done; git -C '$wt' branch -m '$name' 2>/dev/null; cd '$wt' 2>/dev/null; exec zsh" >/dev/null
  wezterm cli activate-pane --pane-id "$pane"
}

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
export DISABLE_SPRING=true
export LEFTHOOK_BIN=bin/lefthook
