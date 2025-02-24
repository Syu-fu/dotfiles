## hooks ##
function cd-ls-hook() {
	ls -a
}
add-zsh-hook chpwd cd-ls-hook

ignore_history() {
	[[ "$?" == 0 ]]
}

add-zsh-hook zshaddhistory ignore_history
