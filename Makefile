export GOPATH := ${HOME}/go

init: ## Initial deploy dotfiles
	mkdir -p ${HOME}/.config
	for item in $(shell ls ${PWD}/.config); do \
		test -L ${HOME}/.config/$$item || rm -rf ${HOME}/.config/$$item; \
		ln -vsfn ${PWD}/.config/$$item ${HOME}/.config/$$item; \
	done
	test -L ${HOME}/.zshenv || rm -rf ${HOME}/.zshenv
	ln -vsfn ${PWD}/.zshenv ${HOME}/.zshenv

.PHONY: backup_pacman backup_npm allbackup

backup_pacman: ## Backup pacman packages
	pacman -Qqe > ${PWD}/packages/pacman_pkglist
	pacman -Qqem > ${PWD}/packages/aur_pkglist

backup_npm: ## Backup npm packages
	npm list -g --depth=0 > ${PWD}/packages/npm_pkglist

backup_go: ## Backup go packages
	for file in $${GOPATH}/bin/* ; do pkg=$$(go version -m "$$file" | head -n2 | tail -n1 | awk '{print $$2}'); echo $$pkg >> "${PWD}/packages/go_pkglist"; done
	@echo "Go packages backed up."

update_pacman:
	@sudo pacman -Syu

update_yay:
	@yay -Syu

update_npm:
	@sudo npm update -g

update_go: ## Update go packages
	for file in $${GOPATH}/bin/* ; do pkg=$$(go version -m "$$file" | head -n2 | tail -n1 | awk '{print $$2}'); echo "Updating $$pkg"; go install "$${pkg}@latest"; done
	@echo "Go packages updated."

install_pacman:
	@cat packages/pacman | xargs sudo pacman -S --needed --noconfirm

install_yay:
	@cat packages/yay | xargs yay -S --needed --noconfirm

install_npm:
	@cat packages/npm | xargs sudo npm install -g

install_go:
	@cat packages/go | xargs -I {} go install {}@latest
	@go install golang.org/x/tools/cmd/godoc@latest

tmuximum:
	@sudo curl -L https://raw.githubusercontent.com/arks22/tmuximum/master/tmuximum -o /usr/local/bin/tmuximum
	@sudo chmod 755 /usr/local/bin/tmuximum

font:
	@mkdir -p fonts
	@curl -LO https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip
	@unzip HackGen_NF_v2.9.0.zip
	@sudo cp ./HackGen_NF_v2.9.0/HackGenConsoleNF-Bold.ttf /usr/share/fonts/TTF/HackGenConsoleNF-Bold.ttf
	@sudo cp ./HackGen_NF_v2.9.0/HackGenConsoleNF-Regular.ttf /usr/share/fonts/TTF/HackGenConsoleNF-Regular.ttf
	rm -rf HackGen_NF_v2.9.0 HackGen_NF_v2.9.0.zip

allbackup: backup_pacman backup_go backup_npm backup_go ## Backup all packages

allupdate: update_pacman update_yay update_npm update_go ## Update all packages

allinstall: install_pacman install_yay install_npm install_go ## Install all packages

chore: tmuximum font

setup: init allinstall allupdate chore


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
