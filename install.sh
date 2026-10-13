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

      # Make Homebrew's bash the login shell (asks for your password once)
      BASH_PATH="$(dirname "$BREW")/bash"
      if [ -x "$BASH_PATH" ] && [ "$(dscl . -read "$HOME" UserShell | awk '{print $2}')" != "$BASH_PATH" ]; then
        echo "==> Switching login shell to $BASH_PATH"
        if grep -qx "$BASH_PATH" /etc/shells || echo "$BASH_PATH" | sudo tee -a /etc/shells >/dev/null; then
          chsh -s "$BASH_PATH" || echo "    Could not change the shell, run: chsh -s $BASH_PATH"
        else
          echo "    Could not add $BASH_PATH to /etc/shells, skipping"
        fi
      fi
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
