#!/bin/sh
# macOS settings. Find new keys with:
#   defaults read > before.txt, change the setting, defaults read > after.txt, diff the two.

# Keyboard: don't turn a double space into a period
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Trackpad: tap to click (built-in, Magic Trackpad, and the login screen)
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: three-finger drag (Accessibility). If it doesn't kick in after
# logging back in, toggle it once in System Settings > Accessibility > Pointer Control.
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Dock: icon size
defaults write com.apple.dock tilesize -int 70

# Finder: list view and path bar
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder ShowPathbar -bool true

# Restart affected apps so changes take effect
killall Finder Dock SystemUIServer 2>/dev/null || true

echo "Some changes need a logout or app restart to take effect."
