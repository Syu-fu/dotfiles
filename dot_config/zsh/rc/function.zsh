## function ##

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
	gh repo create $1 --public --confirm --license "mit"

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

function mkf() {
	mkdir -p "$(dirname "$1")" && touch "$1"
}

function mksc() {
	mkf "$1" && chmod +x "$1"
}

function bd_list() {
	local dir=$PWD
	for i in {1..20}; do
		dir=$(dirname "$dir")
		echo $dir
		if [[ $dir = "/" ]]; then
			break
		fi
	done
}

function bd() {
	local dir=$(bd_list | fzf --reverse --prompt="bd > ")
	if [ -n "$dir" ]; then
		cd $dir
	fi
}
