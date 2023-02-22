# dotfiles

## Tool configuration

OS: Manjaro-i3
WindowManager: i3-wm  
shell: Zsh  
editor: Neovim Stable
Terminal emulator: Alacritty

## Install

```bash
git clone https://github.com/Syu-fu/dotfiles.git
cd dotfiles
./install.sh
```

## Docker

```
cd dotfiles
docker build -t dotfiles .
docker run -it dotfiles zsh
```
