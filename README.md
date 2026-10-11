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
