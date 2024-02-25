#!/usr/bin/bash

gh auth login
gh auth setup-git

# open browser
~/.local/share/chezmoi/bin/open-browser.sh chromium ~/.local/share/chezmoi/chrome/extensions.toml
