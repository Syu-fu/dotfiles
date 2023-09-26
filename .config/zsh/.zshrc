# emacsmode
bindkey -e

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# comp
autoload -U compinit
compinit
autoload -Uz add-zsh-hook
autoload -Uz ignore-history-hook

## term ##
if [ -z $TMUX ]; then
	tmux
fi


## plugin manager ##
function source {
	ensure_zcompiled $1
	builtin source $1
}
function ensure_zcompiled {
	local compiled="$1.zwc"
	if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
		echo "\033[1;36mCompiling\033[m $1"
		zcompile $1
	fi
}
ensure_zcompiled $ZDOTDIR/.zshenv
ensure_zcompiled $ZDOTDIR/.zshrc

cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$ZDOTDIR/sheldon/plugins.toml"
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
	mkdir -p $cache_dir
	sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset cache_dir sheldon_cache sheldon_toml

source $ZDOTDIR/rc/alias.zsh
zsh-defer source $ZDOTDIR/rc/function.zsh
zsh-defer source $ZDOTDIR/rc/completion.zsh
source $ZDOTDIR/rc/hooks.zsh

## local ##
if [ -f "$ZDOTDIR/local.zsh" ]; then
	source "$ZDOTDIR/local.zsh"
fi

unset -f source
