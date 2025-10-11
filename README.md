# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Installation

To install these dotfiles on a new machine, run:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Syu-fu
```

This will:
1. Install chezmoi if not already installed
2. Clone this repository
3. Apply all dotfiles to your home directory