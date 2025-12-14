#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# ---------- helper ----------
link() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Skipping $dest (already exists)"
  else
    ln -s "$src" "$dest"
    echo "Linked $dest → $src"
  fi
}

# ----------- link ----------
mkdir -p "$HOME"
link "$DOTFILES_DIR/root_config/zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/root_config/tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES_DIR/root_config/gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/root_config/gitignore" "$HOME/.gitignore"
link "$DOTFILES_DIR/root_config/inputrc" "$HOME/.inputrc"
link "$DOTFILES_DIR/root_config/latexmkrc" "$HOME/.latexmkrc"
link "$DOTFILES_DIR/root_config/Rprofile" "$HOME/.Rprofile"

echo "Done ✅"
