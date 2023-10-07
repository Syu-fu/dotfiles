if command -v aqua &> /dev/null; then source <(aqua completion zsh); fi
if command -v hugo &> /dev/null; then source <(hugo completion zsh); fi
if command -v deno &> /dev/null; then source <(deno completions zsh); fi
if command -v golangci-lint &> /dev/null; then source <(golangci-lint completion zsh); fi
if command -v yq &> /dev/null; then (yq shell-completion zsh)> $ZDOTDIR/completions/_yq; fi
if command -v gh &> /dev/null; then (gh completion --shell zsh)> $ZDOTDIR/completions/_gh; fi
if command -v fd &> /dev/null; then (fd --gen-completions)> $ZDOTDIR/completions/_fd; fi
