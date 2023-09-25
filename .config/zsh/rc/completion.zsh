if command -v aqua &> /dev/null; then source <(aqua completion zsh); fi
if command -v golangci-lint &> /dev/null; then source <(golangci-lint completion zsh); fi
if command -v gh &> /dev/null; then (gh completion --shell zsh)> $ZDOTDIR/completions/_gh; fi
if command -v fd &> /dev/null; then (fd --gen-completions)> $ZDOTDIR/completions/_fd; fi
if command -v rg &> /dev/null && [ ! -e $ZDOTDIR/completions/_rg ]; then
	(curl -s "https://raw.githubusercontent.com/BurntSushi/ripgrep/master/complete/_rg")> $ZDOTDIR/completions/_rg;
fi
if command -v ghq &> /dev/null && [ ! -e $ZDOTDIR/completions/_ghq ]; then
	(curl -s "https://raw.githubusercontent.com/x-motemen/ghq/master/misc/zsh/_ghq")> $ZDOTDIR/completions/_ghq;
fi
