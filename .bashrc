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
export NODE_EXTRA_CA_CERTS="$HOME/.claude/certs/obsidian-local-rest-api.pem"

# Local secrets (API keys, etc.) — not tracked, lives outside this repo
[ -f "$HOME/.bashrc_secrets" ] && . "$HOME/.bashrc_secrets"

# ===== Claude Native =====
claude-native() {
  unset ANTHROPIC_BASE_URL
  unset ANTHROPIC_AUTH_TOKEN
  unset ANTHROPIC_MODEL
  unset ANTHROPIC_DEFAULT_OPUS_MODEL
  unset ANTHROPIC_DEFAULT_SONNET_MODEL
  unset ANTHROPIC_DEFAULT_HAIKU_MODEL
  unset CLAUDE_CODE_SUBAGENT_MODEL
  unset CLAUDE_CODE_EFFORT_LEVEL
}

# ===== Claude via DeepSeek =====
claude-deepseek() {
  export DEEPSEEK_API_KEY

  export ANTHROPIC_BASE_URL=api.deepseek.com/anthropic
  export ANTHROPIC_AUTH_TOKEN=${DEEPSEEK_API_KEY}

  export ANTHROPIC_MODEL=deepseek-v4-pro[1m]
  export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]
}

claude-kimi() {
  export KIMI_API_KEY

  export ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
  export ANTHROPIC_AUTH_TOKEN=${KIMI_API_KEY}

  export ANTHROPIC_MODEL="kimi-k2.5"
  export ANTHROPIC_DEFAULT_OPUS_MODEL="kimi-k3"
}
