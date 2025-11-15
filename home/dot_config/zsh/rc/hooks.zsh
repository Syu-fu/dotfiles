# Auto ls after cd
function cd-ls-hook() {
	ls -a
}
add-zsh-hook chpwd cd-ls-hook

# Ignore failed commands in history
ignore_history() {
	[[ "$?" == 0 ]]
}
add-zsh-hook zshaddhistory ignore_history
