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
- `Brewfile`: Homebrew packages, installed with `brew bundle`
- `shell/bashrc`, `shell/bash_profile`, `shell/inputrc`: bash config, symlinked into `$HOME`. `shell/starship.toml` is the prompt, linked to `~/.config/starship.toml`. Machine-specific settings and secrets go in `~/.bashrc.local`, which is never committed.
- `git/ignore`: global gitignore, linked to `~/.config/git/ignore`
- `macos/defaults.sh`: macOS settings (`defaults write ...`): keyboard, trackpad, Dock, Finder
- `macos/iterm.sh`: iTerm2 global settings, installs the profile
- `macos/iterm/profile.json`: iTerm2 profile (fonts, colors, scrollback, keys, new tab behavior) as a Dynamic Profile
