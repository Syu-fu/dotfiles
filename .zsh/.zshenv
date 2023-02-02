export LANG=ja_JP.UTF-8
export XDG_CONFIG_HOME=~/.config
export PATH=$PATH:$HOME/.composer/vendor/bin
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
# bat-theme
export BAT_THEME="gruvbox-dark"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# linuxbrew
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export LD_LIBRARY_PATH="/home/linuxbrew/.linuxbrew/lib:$LD_LIBRARY_PATH"
export GOPATH="$HOME/go"
export DENO_INSTALL="/$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$GOPATH/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"

export MEMODIR="$HOME/Documents/Projects/github.com/Syu-fu/memo"

export NEXTWORD_DATA_PATH=$HOME/dic/nextword-data-large

path=(
  /usr/local/{bin,sbin}
  $path
)
# history
HISTFILE=$ZDOTDIR/.zhistory
