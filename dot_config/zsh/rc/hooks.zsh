## hooks ##
function cd-ls-hook() {
	ls -a
}
add-zsh-hook chpwd cd-ls-hook

export HIST_IGNORE_COMMAND="ls:cd:nvim:vim:less:which:whois:lazygit:xdg-open"

function my_zshaddhistory() {
	LASTHIST=$1

	return 2
}

# HIST_IGNORE_COMMANDのコマンドは記録しない
# HISTFILEの最後にコマンドを記録
# 重複する行はファイル上のものを削除してから最終行に追加
# 空白から始まるコマンドは記録しない
# 失敗したコマンドは記録しない
# 直前に実行されたコマンドはLASTHISTに保存される
function save_last_command_in_history_if_successful() {
	# ignore empty command
	if [[ ! -n ${LASTHIST:#[[:blank:]]*} ]]; then
		return
	fi

	# ignore failed command
	if [ ! $? -eq 0 ]; then
		return
	fi

	# ignore space start command
	if [[ ! ${LASTHIST} =~ ^\s ]]; then
		local command_name=$(echo ${LASTHIST} | awk '{print $1}')
		if [[ ! -n ${command_name} ]]; then
			return
		fi
		# ignore HIST_IGNORE_COMMAND
		for cmd in ${(s.:.)HIST_IGNORE_COMMAND}; do
			if [[ "$command_name" == "$cmd" ]]; then
				return
			fi
		done

		# delete last history if it is duplicated
		escaped_last_hist=$(echo "$LASTHIST" | sed 's/[\/&]/\\&/g')
		if [ -f "${HISTFILE}" ]; then
			sed -i "/^$escaped_last_hist$/d" "${HISTFILE}"
		fi

		echo "${LASTHIST%$'\n'}" >>"${HISTFILE}"
	fi
}

add-zsh-hook precmd save_last_command_in_history_if_successful
add-zsh-hook zshexit save_last_command_in_history_if_successful
add-zsh-hook zshaddhistory my_zshaddhistory
