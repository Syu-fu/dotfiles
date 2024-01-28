#!/bin/bash

set -eu

DOTFILES_DIR=$(cd "$(dirname "$0")"/..; pwd)

while IFS= read -r f
do
	if [ -d "$f" ] && [ ! -e "$HOME/${f##"$DOTFILES_DIR"/home/}" ]; then
		mkdir -p "$HOME/${f##"$DOTFILES_DIR"/home/}"
	else
		# ホームディレクトリにsymlinkを貼る
		ln -sf "$f" "$HOME/${f##"$DOTFILES_DIR"/home/}"
	fi
done < <(find "$DOTFILES_DIR"/home)

echo -e "\e[32mSuccess deploy!\e[0m"
