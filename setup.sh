#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Files that live directly in ~
HOME_FILES=(
  .bashrc
  .bash_profile
  .zshrc
  .profile
  .gitconfig
  .gitconfig-work
)

# Dirs that live in ~/.config/
CONFIG_DIRS=(
  hypr
  nvim
  kitty
  foot
  niri
  fuzzel
  fish
)

# ── helpers ──────────────────────────────────────────────────────────────────

link() {
  local src="$1" dst="$2"

  if [[ -L "$dst" ]]; then
    # Already a symlink — skip (idempotent)
    echo "  skip   $dst (already linked)"
    return
  fi

  if [[ -e "$dst" ]]; then
    # Real file/dir exists — back it up
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "  backup $dst -> $BACKUP_DIR/$(basename "$dst")"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "  link   $dst -> $src"
}

# ── home files ───────────────────────────────────────────────────────────────

echo ""
echo "Linking home files..."
for f in "${HOME_FILES[@]}"; do
  src="$DOTFILES/$f"
  if [[ -e "$src" ]]; then
    link "$src" "$HOME/$f"
  else
    echo "  skip   $f (not in dotfiles yet)"
  fi
done

# ── config dirs ──────────────────────────────────────────────────────────────

echo ""
echo "Linking config dirs..."
for d in "${CONFIG_DIRS[@]}"; do
  src="$DOTFILES/.config/$d"
  if [[ -e "$src" ]]; then
    link "$src" "$HOME/.config/$d"
  else
    echo "  skip   .config/$d (not in dotfiles yet)"
  fi
done

echo ""
echo "Done."
[[ -d "$BACKUP_DIR" ]] && echo "Backups saved to $BACKUP_DIR"
