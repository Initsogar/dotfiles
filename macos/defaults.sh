#!/bin/sh
# macOS settings. Find new keys with:
#   defaults read > before.txt, change the setting, defaults read > after.txt, diff the two.

# Keyboard: don't turn a double space into a period
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Restart affected apps so changes take effect
killall Finder Dock SystemUIServer 2>/dev/null || true

echo "Some changes need a logout or app restart to take effect."
