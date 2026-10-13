#!/bin/sh
# iTerm2 settings. Only what differs from a fresh install.
# The profile lives in iterm/profile.json as a Dynamic Profile. It is copied, not symlinked,
# so a git pull never changes iTerm2 until you review it and run this again.
# Quit iTerm2 before running, or it may overwrite these on exit.

DIR="$(cd "$(dirname "$0")" && pwd)"
PROFILES="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
GUID="$(plutil -extract Profiles.0.Guid raw -o - "$DIR/iterm/profile.json")" || exit 1

# Profile: install it and make it the default
mkdir -p "$PROFILES"
install -m 644 "$DIR/iterm/profile.json" "$PROFILES/dotfiles.json"
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$GUID"

# General
defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true
