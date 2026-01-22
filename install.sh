#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# ---------- OS Detection ----------
case "$(uname -s)" in
    Darwin)
        PLATFORM="mac"
        TEXMF_HOME="$HOME/Library/texmf"
        ;;
    Linux)
        PLATFORM="linux"
        TEXMF_HOME="$HOME/texmf"
        ;;
    *)
        PLATFORM="unknown"
        ;;
esac

# ---------- helper ----------
link() {
  local src="$1"
  local dest="$2"

  # Ensure the parent directory of the destination exists
  mkdir -p "$(dirname "$dest")"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Skipping $dest (already exists)"
  else
    ln -s "$src" "$dest"
    echo "Linked $dest → $src"
  fi
}

# ----------- link standard configs ----------
link "$DOTFILES_DIR/root_config/zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/root_config/tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES_DIR/root_config/gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/root_config/gitignore" "$HOME/.gitignore"
link "$DOTFILES_DIR/root_config/inputrc" "$HOME/.inputrc"
link "$DOTFILES_DIR/root_config/latexmkrc" "$HOME/.latexmkrc"
link "$DOTFILES_DIR/root_config/Rprofile" "$HOME/.Rprofile"

# ----------- link LaTeX files ----------
# LaTeX is picky: .sty files MUST be in texmf/tex/latex/
if [ "$PLATFORM" != "unknown" ]; then
    echo "Configuring LaTeX for $PLATFORM..."
    
    # Path to where your style files are kept in your dotfiles
    # Assuming your dotfiles has a folder named 'latex' containing paper.sty
    LATEX_SRC="$DOTFILES_DIR/latex" 
    
    # Path to the specific LaTeX search directory
    LATEX_DEST="$TEXMF_HOME/tex/latex/common"

    link "$LATEX_SRC" "$LATEX_DEST"
fi

echo "Done ✅"
