#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# git worktree add + copy .env from repo root
# usage: wta <branch> <path>
wta() {
  local branch="$1"
  local path="$2"
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "Not in a git repo"; return 1; }
  git worktree add -b "$branch" "$path" || return 1
  if [ -f "$root/.env" ]; then
    cp "$root/.env" "$path/.env"
    echo "Copied .env → $path/.env"
  else
    echo "No .env found in $root, skipping"
  fi
}
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$PATH:$HOME/development/flutter/bin"

. "$HOME/.local/share/../bin/env"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
