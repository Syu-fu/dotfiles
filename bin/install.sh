#!/bin/bash

# if macos homebrew install
if [ "$(uname)" == 'Darwin' ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo -e "\e[32mSuccess install homebrew!\e[0m"

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
	echo -e "\e[31mcurl or wget or git required \e[m"
	exit 1
fi

echo -e "\e[32mSuccess clone dotfiles!\e[0m"

# apply dotfiles

brew install chezmoi

chezmoi apply

echo -e "\e[32mSuccess apply dotfiles!\e[0m"

# setup zsh

brew install zsh
brew install sheldon

echo -e "\e[32mSuccess install zsh and sheldon!\e[0m"

brew bundle --file="$HOME"/.local/share/chezmoi/Brewfile

echo -e "\e[32mSuccess install Brewfile!\e[0m"

.~/.local/share/chezmoi/bin/open-browser.sh chromium ~/.local/share/chezmoi/chrome/extensions.toml
