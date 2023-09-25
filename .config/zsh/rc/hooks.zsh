## hooks ##
function cd-ls-hook() {
	ls -a
}
add-zsh-hook chpwd cd-ls-hook

function ignore-history-hook() {
	local line=${1%%$'\n'}
	local cmd=${line%% *}

	[[ ${#line} -ge 5
		&& ${cmd} != 'ls'
		&& ${cmd} != 'cd'
		&& ${cmd} != 'nv'
		&& ${cmd} != 'vim'
		&& ${cmd} != 'less'
		&& ${cmd} != 'which'
		&& ${cmd} != 'whois'
		&& ${cmd} != 'pacman'
		&& ${cmd} != 'xdg-open'
	]]
}
add-zsh-hook zshaddhistory ignore-history-hook

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
