# emacsmode
bindkey -e

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# comp
autoload -U compinit
compinit
autoload -Uz add-zsh-hook

## alias ##
alias ..='cd ..'
alias p='cd $HOME/Documents/Projects'

if command -v lsd > /dev/null; then
	alias ls="lsd"
fi

alias nv='nvim'
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

alias copypath='pwd | tr -d "\n" | xsel --clipboard --input'
alias lock='i3lock -i ~/.config/i3/wallpaper_lock.png && sleep 1'
alias myip="ip -4 a show wlp0s20f3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"

## term ##
if [ -z $TMUX ]; then
	tmux
fi

## hooks ##
function cd-ls-hook() {
	ls -a
}
add-zsh-hook chpwd cd-ls-hook

## function ##
function do-enter() {
	if [ -n "$BUFFER" ]; then
		zle accept-line
		return 0
	fi
	echo ""
	ls -a
	echo "\n"
	zle reset-prompt
	return 0
}
zle -N do-enter
bindkey '^m' do-enter

function select-history() {
	BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
	CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# auto suggestion
bindkey '^j' autosuggest-accept

## plugin manager ##
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$ZDOTDIR/plugins.toml"
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
	mkdir -p $cache_dir
	sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset cache_dir sheldon_cache sheldon_toml

## local ##
if [ -f "$ZDOTDIR/local.zsh" ]; then
	source "$ZDOTDIR/local.zsh"
fi
