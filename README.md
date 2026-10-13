# dotfiles

Because I refuse to configure things twice.

## Setup

```sh
git clone https://github.com/Initsogar/dotfiles.git ~/Workspace/dotfiles
cd ~/Workspace/dotfiles
./install.sh
```

`install.sh` detects the OS and only applies what fits.

## Layout

- `install.sh`: entry point
- `macos/defaults.sh`: macOS settings (`defaults write ...`)
- `macos/iterm.sh`: iTerm2 global settings, installs the profile
- `macos/iterm/profile.json`: iTerm2 profile (scrollback, keys, new tab behavior) as a Dynamic Profile
