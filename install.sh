#!/usr/bin/env bash
set -euo pipefail # Better error handling

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- OS & Path Detection ----------
PLATFORM="unknown"
case "$(uname -s)" in
    Darwin) PLATFORM="mac";   TEXMF_HOME="$HOME/Library/texmf" ;;
    Linux)  PLATFORM="linux"; TEXMF_HOME="$HOME/texmf" ;;
esac

# Dynamically find Pandoc's preferred data directory
if command -v pandoc >/dev/null 2>&1; then
    # Extracts the directory path from the 'User data directory' line
    PANDOC_DATA_DIR=$(pandoc --version | grep "User data directory" | awk -F': ' '{print $2}' | xargs)
else
    # Fallback to XDG standard if pandoc isn't installed yet
    PANDOC_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/pandoc"
fi

# ---------- Helpers ----------
success() { echo -e "\033[32m[OK]\033[0m $1"; }
info() { echo -e "\033[34m[INFO]\033[0m $1"; }

link() {
    local src="$1"
    local dest="$2"
    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ]; then
        if [ "$(readlink "$dest")" == "$src" ]; then
            return # Already linked correctly
        fi
        rm "$dest" # Replace old/broken symlink
    elif [ -e "$dest" ]; then
        info "Backing up existing $dest to ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -s "$src" "$dest"
    success "Linked $dest → $src"
}

# ----------- Link Configs ----------
info "Installing standard configs..."
configs=(
    "root_config/zshrc:.zshrc"
    "root_config/tmuxconf:.tmux.conf"
    "root_config/gitconfig:.gitconfig"
    "root_config/gitignore:.gitignore"
    "root_config/latexmkrc:.latexmkrc"
)

for entry in "${configs[@]}"; do
    IFS=":" read -r src_rel dest_rel <<< "$entry"
    link "$DOTFILES_DIR/$src_rel" "$HOME/$dest_rel"
done

# ----------- Pandoc Setup ----------
info "Configuring Pandoc at $PANDOC_DATA_DIR"
# Link the whole directory to maintain /templates, /filters, and /defaults structure
link "$DOTFILES_DIR/pandoc" "$PANDOC_DATA_DIR"

# ----------- LaTeX Setup ----------
if [ "$PLATFORM" != "unknown" ]; then
    info "Configuring LaTeX ($PLATFORM)..."
    link "$DOTFILES_DIR/tex" "$TEXMF_HOME/tex"
fi

success "Installation complete ✅"
