## hooks ##
function cd-ls-hook() {
	ls -a
}
add-zsh-hook chpwd cd-ls-hook

remove_last_history_if_not_needed() {
	local last_status="$?"
	if [[ ${last_status} -ne 0 ]]; then
		fc -W
		ed -s ${HISTFILE} <<EOF >/dev/null
d
w
q
EOF
		fc -R
	fi
}

add-zsh-hook precmd remove_last_history_if_not_needed
