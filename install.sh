#!/bin/sh
# Set up this machine. Safe to run more than once.
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Symlink a repo file into $HOME, keeping any existing real file as .bak
link() {
  target="$HOME/$2"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.bak"
    echo "    kept your old $2 as $2.bak"
  fi
  ln -sf "$DOTFILES/$1" "$target"
}

case "$(uname -s)" in
  Darwin)
    echo "==> macOS detected"
    BREW=""
    for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
      [ -x "$b" ] && BREW="$b" && break
    done
    if [ -n "$BREW" ]; then
      echo "==> Installing Homebrew packages"
      "$BREW" bundle --no-upgrade --file="$DOTFILES/Brewfile"
    else
      echo "==> Homebrew not found, skipping the Brewfile."
      echo "    Install it from https://brew.sh and run this script again."
    fi
    echo "==> Applying macOS defaults"
    sh "$DOTFILES/macos/defaults.sh"
    echo "==> Applying iTerm2 settings"
    sh "$DOTFILES/macos/iterm.sh"
    ;;
  Linux)
    echo "==> Linux detected"
    ;;
  *)
    echo "Unsupported OS: $(uname -s)"
    exit 1
    ;;
esac

echo "==> Linking shell files"
link shell/bashrc .bashrc
link shell/bash_profile .bash_profile
link shell/starship.toml .config/starship.toml

echo "==> Done"
