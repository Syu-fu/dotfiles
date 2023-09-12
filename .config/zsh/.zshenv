# locate
export LANG=ja_JP.UTF-8

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# Go
export GOPATH="$HOME/go"

# Deno
export DENO_INSTALL="$HOME/.deno"

# tools
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

export BAT_THEME="gruvbox-dark"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
export MEMODIR="$HOME/Documents/Projects/github.com/Syu-fu/memo"

# history
export HISTFILE=~/Dropbox/dev/zsh/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000
export LISTMAX=10000

export PATH="$DENO_INSTALL/bin:$GOPATH/bin:$PATH"

export SHELDON_CONFIG_DIR="$ZDOTDIR/sheldon"
