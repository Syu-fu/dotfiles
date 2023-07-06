# emacsmode
bindkey -e

## hooks ##
function chpwd () {
	ls -a
}

# tmuxのwindow nameをrepository nameあるいはcurrent directory nameに変更
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%r'

precmd () {
	LANG=en_US.UTF-8
	if git rev-parse 2>/dev/null; then
		tmux rename-window `basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null` 2>/dev/null
	else
		tmux rename-window `basename $(pwd)`
	fi
}

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# comp
autoload -U compinit
compinit

# alias {{{
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias p='cd $HOME/Documents/Projects'

if command -v lsd > /dev/null; then
	alias ls="lsd"
fi

# alias fzf='fzf-tmux -p 80%'

alias nv='nvim'

alias copypath='pwd | tr -d "\n" | pbcopy'
alias lock='i3lock -i ~/.config/i3/wallpaper_lock.png && sleep 1'

## autocompletion ##
# Load fzf key-bindings if they exist
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
	source /usr/share/fzf/key-bindings.zsh
fi

# Load fzf completions if they exist
if [ -f /usr/share/fzf/completion.zsh ]; then
	source /usr/share/fzf/completion.zsh
fi


# zinit読み込み
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
	print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
	command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
	command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
		print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
		print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# term
if [ -z $TMUX ]; then
	tmuximum
fi
# auto suggestion
zinit ice wait'!0';zinit light zsh-users/zsh-autosuggestions
bindkey '^j' autosuggest-accept
# syntax-highlight
zinit ice wait'!0';zinit light zdharma-continuum/fast-syntax-highlighting
# p10k
zinit ice depth=1;zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
zinit ice depth=1;zinit light chitoku-k/fzf-zsh-completions

# function
# select project
function fzf-src() {
	local src=$(ghq list -full-path | fzf --query "$BUFFER")
	if [ -n "$src" ]; then
		BUFFER="cd $src"
		zle accept-line
	fi
	zle -R -c
}
zle -N fzf-src
bindkey '^]' fzf-src
# Enterを押すとls
function do-enter() {
	if [ -n "$BUFFER" ]; then
		zle accept-line
		return 0
	fi
	echo ""
	if command -v lsd > /dev/null; then
		lsd -a
	else
		ls -a
	fi
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

## local ##
if [ -f "$ZDOTDIR/local.zsh" ]; then
	source "$ZDOTDIR/local.zsh"
fi
