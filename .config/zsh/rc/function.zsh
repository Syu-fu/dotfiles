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

function github-new() {
	if [ $# -eq 0 ]; then
		echo "Please specify a repository name"
		return 1
	fi

	# Create repository on GitHub
	gh repo create $1 --public --confirm

	if [ $? -ne 0 ]; then
		echo "Failed to create repository"
		return 1
	fi

	# Clone using ghq
	ghq get "https://github.com/$(gh api user | jq -r .login)/$1.git"

	if [ $? -ne 0 ]; then
		echo "Failed to clone with ghq"
		return 1
	fi

	echo "$1 was successfully created and cloned"
}
