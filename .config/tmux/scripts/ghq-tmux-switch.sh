#!/bin/bash

# Set color variables
green=$(tput setaf 2) blue=$(tput setaf 4)
reset=$(tput sgr0)

# Set checkmark variables
checked="󰄲"
unchecked="󰄱"

window_exists() {
	tmux list-windows -t "$1" >/dev/null 2>&1
}

# Generate window list
generate_window_list() {
	ghq list | sort | while read -r repo; do
		window="${repo//[:. ]/-}"
		color="$blue"
		icon="$unchecked"
		if window_exists "$window"; then
			color="$green"
			icon="$checked"
		fi
		printf "$color$icon %s$reset\n" "$repo"
	done
}

# Define preview command
preview_cmd="echo {} | cut -d' ' -f2- | xargs -I% sh -c 'bat --color=always --style=plain \$(find \"\$(ghq root)/%\" -maxdepth 1 | grep -i -E \"README(\\..*)?\")'"

# Select window
selected="$(generate_window_list | fzf-tmux -p 80% --ansi --exit-0 --preview="$preview_cmd" --preview-window="right:60%" | cut -d' ' -f2-)"

# If not inside a tmux session, attach or create
session_name="${selected//[:. ]/-}"
repo_dir="$(ghq list --exact --full-path "$selected")"

if [ -z "$TMUX" ]; then
	if tmux has-session -t "$session_name" 2>/dev/null; then
		BUFFER="tmux attach-session -t ${session_name}"
	else
		tmux new-session -d -s "${session_name}" -c "${repo_dir}"
		BUFFER="tmux attach-session -t ${session_name}"
	fi
else
	if [ "$(tmux display-message -p "#S")" != "$session_name" ]; then
		if tmux has-session -t "$session_name" 2>/dev/null; then
		    tmux switch-client -t "$session_name"
		else
		    tmux new-session -d -s "${session_name}" -c "${repo_dir}"
		    tmux switch-client -t "$session_name"
		fi
	elif [ "$PWD" != "$repo_dir" ]; then
		BUFFER="cd ${repo_dir}"
	fi
fi

eval "$BUFFER"
