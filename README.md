# dotfiles

![](https://github.com/Syu-fu/dotfiles/workflows/benchmark/badge.svg)

## Image

![image](https://raw.githubusercontent.com/Syu-fu/dotfiles/main/doc/dotfiles-screenshot.png)

## Tool configuration
OS: Ubuntu 20.04 LTS  
WindowManager: i3-wm  
shell: Zsh  
editor: Neovim v0.6.1  
Terminal emulator: Alacritty

## Install

``` bash
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

## Benchmark

[https://syu-fu.github.io/dotfiles/dev/bench/](https://syu-fu.github.io/dotfiles/dev/bench/)
