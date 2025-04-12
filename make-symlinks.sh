#!/bin/zsh

DOTFILES_DIR="$HOME/Coding/dotfiles"

# Check if the dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "❌ Error: Directory '$DOTFILES_DIR' does not exist."
  exit 1
fi

echo "📁 Found dotfiles directory: $DOTFILES_DIR"
echo "🔗 Creating symlinks in $HOME..."

# Loop through all dotfiles in the directory
for file in "$DOTFILES_DIR"/.*(N); do
  filename="${file:t}"

  # Skip '.' and '..'
  if [[ "$filename" == "." || "$filename" == ".." ]]; then
    continue
  fi

  target="$HOME/$filename"

  # Remove existing symlink if present
  if [[ -L "$target" ]]; then
    echo "🧹 Removing existing symlink: $target"
    rm "$target"
  fi

  echo "🔗 Linking $file -> $target"
  ln -s "$file" "$target"
done

echo "✅ Done!"