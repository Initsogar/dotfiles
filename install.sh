#!/bin/sh
# Set up this machine. Safe to run more than once.
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

case "$(uname -s)" in
  Darwin)
    echo "==> macOS detected"
    echo "==> Applying macOS defaults"
    sh "$DOTFILES/macos/defaults.sh"
    echo "==> Applying iTerm2 settings"
    sh "$DOTFILES/macos/iterm.sh"
    ;;
  Linux)
    echo "==> Linux detected, nothing to do yet"
    ;;
  *)
    echo "Unsupported OS: $(uname -s)"
    exit 1
    ;;
esac

echo "==> Done"
