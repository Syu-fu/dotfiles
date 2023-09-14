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
