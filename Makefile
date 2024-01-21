export GOPATH := ${HOME}/go

init: ## Initial deploy dotfiles
	mkdir -p ${HOME}/.config
	for item in $(shell ls ${PWD}/.config); do \
		test -L ${HOME}/.config/$$item || rm -rf ${HOME}/.config/$$item; \
		ln -vsfn ${PWD}/.config/$$item ${HOME}/.config/$$item; \
	done
	test -L ${HOME}/.zshenv || rm -rf ${HOME}/.zshenv
	ln -vsfn ${PWD}/.zshenv ${HOME}/.zshenv

backup_pacman: ## Backup pacman packages
	pacman -Qqe > ${PWD}/packages/pacman_pkglist
	pacman -Qqem > ${PWD}/packages/aur_pkglist

backup_npm: ## Backup npm packages
	npm list -g --depth=0 > ${PWD}/packages/npm_pkglist

.PHONY: update_pacman update_yay update_npm
update_pacman:
	@sudo pacman -Syu

update_yay:
	@yay -Syu

update_npm:
	@sudo npm update -g

install_pacman:
	@cat packages/pacman | xargs sudo pacman -S --needed --noconfirm

install_yay:
	@cat packages/yay | xargs yay -S --needed --noconfirm

install_npm:
	@cat packages/npm | xargs sudo npm install -g

install_aqua:
	@aqua install

init_aqua:
	@curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.1.1/aqua-installer | bash

init_neomutt:
	@mkdir -p ${HOME}/.local/share/neomutt/cache/headers
	@mkdir -p ${HOME}/.local/share/neomutt/cache/bodies

.PHONY: tmuximum font chrome
tmuximum:
	@sudo curl -L https://raw.githubusercontent.com/arks22/tmuximum/master/tmuximum -o /usr/local/bin/tmuximum
	@sudo chmod +x /usr/local/bin/tmuximum

font:
	@mkdir -p fonts
	@curl -LO https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip
	@unzip HackGen_NF_v2.9.0.zip
	@sudo cp ./HackGen_NF_v2.9.0/HackGenConsoleNF-Bold.ttf /usr/share/fonts/TTF/HackGenConsoleNF-Bold.ttf
	@sudo cp ./HackGen_NF_v2.9.0/HackGenConsoleNF-Regular.ttf /usr/share/fonts/TTF/HackGenConsoleNF-Regular.ttf
	rm -rf HackGen_NF_v2.9.0 HackGen_NF_v2.9.0.zip

chrome:
	@./bin/open-browser.sh chromium ./chrome/extensions.txt

allbackup: backup_pacman backup_yay backup_npm ## Backup all packages

allupdate: update_pacman update_yay update_npm ## Update all packages

allinstall: install_pacman install_yay install_npm install_aqua ## Install all packages

chore: tmuximum font

setup: init init_aqua allinstall allupdate chore


.PHONY: help
help:
	@echo "Available commands:"
	@echo "  init                  - Initialize the dotfiles."
	@echo "  allbackup             - Run all backup commands."
	@echo "  allupdate             - Run all update commands."
	@echo "  allinstall            - Run all install commands."
	@echo "  setup                 - Run init, allinstall, and allupdate commands."
	@echo "  chore                 - "
	@echo "  help                  - Show this help message."
