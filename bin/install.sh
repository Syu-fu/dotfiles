#!/bin/bash

# if macos homebrew install
if [ "$(uname)" == 'Darwin' ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo -e "\e[32mSuccess install homebrew!\e[0m"

brew install git

# clone dotfiles
if command -v "git" &>/dev/null; then
	git clone https://github.com/Syu-fu/dotfiles.git "$HOME"/src/github.com/Syu-fu/dotfiles
elif command -v "curl" &>/dev/null || command -v "wget" &>/dev/null; then
	TARBALL="https://github.com/Syu-fu/dotfiles/archive/main.tar.gz"
	if has "curl"; then
		curl -L ${TARBALL} -o main.tar.gz
	else
		wget ${TARBALL}
	fi
	tar -zxvf main.tar.gz
	rm -f main.tar.gz
	mv -f dotfiles-main "$HOME"/src/github.com/Syu-fu/dotfiles

else
	echo -e "\e[31mcurl or wget or git required \e[m"
	exit 1
fi

echo -e "\e[32mSuccess clone dotfiles!\e[0m"

echo -e "\e[34mMove directory \e[0m"
cd "$HOME"/src/github.com/Syu-fu/dotfiles || exit 1

make setup
