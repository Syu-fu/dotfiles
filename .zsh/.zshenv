export LANG=ja_JP.UTF-8
export XDG_CONFIG_HOME=~/.config
export PATH=$PATH:$HOME/.composer/vendor/bin
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
# bat-theme
export BAT_THEME="gruvbox-dark"
# linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export LD_LIBRARY_PATH="/home/linuxbrew/.linuxbrew/lib:$LD_LIBRARY_PATH"

path=(
  /usr/local/{bin,sbin}
  $path
)
# history
HISTFILE=$ZDOTDIR/.zhistory
