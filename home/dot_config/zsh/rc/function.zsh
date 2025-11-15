# Interactive history search with fzf
function select-history() {
	BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
	CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# Create GitHub repository and clone with ghq
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

# Create file with parent directories
function mkf() {
	mkdir -p "$(dirname "$1")" && touch "$1"
}

# Create executable script file with parent directories
function mksc() {
	mkf "$1" && chmod +x "$1"
}

# List parent directories
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

# Interactive parent directory navigation with fzf
function bd() {
	local dir=$(bd_list | fzf --reverse --prompt="bd > ")
	if [ -n "$dir" ]; then
		cd $dir
	fi
}
