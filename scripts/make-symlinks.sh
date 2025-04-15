#!/bin/zsh

SCRIPT_DIR="$(cd -- "$(dirname -- "${(%):-%N}")" && pwd)" # Get the directory where this script lives
PARENT_DIR="$(dirname "$SCRIPT_DIR")" # Get the parent of that directory
DOTFILES_DIR="$PARENT_DIR"

# List of approved dotfiles to symlink
APPROVED_DOTFILES=(
  ".gitconfig"
  ".gitignore"
  ".zprofile"
  ".zshrc"
)

# Check if the dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "❌ Error: Directory '$DOTFILES_DIR' does not exist."
  exit 1
fi

echo "📁 Found dotfiles directory: $DOTFILES_DIR"

# Loop through all dotfiles in the directory
for filename in "${APPROVED_DOTFILES[@]}"; do
  src="$DOTFILES_DIR/$filename"
  dest="$HOME/$filename"

  if [[ ! -e "$src" ]]; then
    echo "⚠️  Skipping $filename — file not found in $DOTFILES_DIR"
    continue
  fi

  if [[ -L "$dest" || -e "$dest" ]]; then
    echo "🧹 Removing existing file or symlink: ~/$filename"
    rm -rf "$dest"
  fi

  ln -s "$src" "$dest"
  echo "🔗 Linked $filename"
done

echo "✅ Done!"