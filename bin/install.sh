#!/bin/bash

# if macos homebrew install
if [ "$(uname)" == 'Darwin' ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo $'\e[32;1mSuccess install homebrew!\e[m'

brew install git

# clone dotfiles
if command -v "git" &>/dev/null; then
	git clone https://github.com/Syu-fu/dotfiles.git "$HOME"/.local/share/chezmoi
elif command -v "curl" &>/dev/null || command -v "wget" &>/dev/null; then
	TARBALL="https://github.com/Syu-fu/dotfiles/archive/main.tar.gz"
	if has "curl"; then
		curl -L ${TARBALL} -o main.tar.gz
	else
		wget ${TARBALL}
	fi
	tar -zxvf main.tar.gz
	rm -f main.tar.gz
	mv -f dotfiles-main "$HOME"/.local/share/chezmoi

else
	echo $'\e[31;1mPlease install curl or wget or git\e[m'
	exit 1
fi

echo $'\e[32;1mSuccess clone dotfiles!\e[m'

# apply dotfiles

brew install chezmoi

chezmoi apply

echo $'\e[32;1mSuccess apply dotfiles!\e[m'

# setup zsh

brew install zsh

brew bundle --file="$HOME"/.local/share/chezmoi/Brewfile

echo $'\e[32;1mSuccess install Brewfile!\e[m'

aqua install

echo $'\e[32;1mSuccess install aqua!\e[m'

mise install

echo $'\e[32;1mSuccess install mise!\e[m'

# macOS settings
if [ "$(uname)" == 'Darwin' ]; then
	defaults write com.apple.finder AppleShowAllFiles TRUE
fi
