#!/usr/bin/env bash
DOT_DIR=`pwd`
GITHUB_URL="https://github.com/Syu-fu/dotfiles"
echo "  begin link dotfiles."

if cd "$DOT_DIR"; then
  for f in $(find . -not -path '*.git/*' -not -path '*.DS_Store' -not -path '*.gitignore' -not -path '.github/*' -path '*/.*' -type f -print | cut -b3-)
  do
    mkdir -p ~/$(dirname "$f")
    if [ -L ~/$f ]; then
      ln -sfv "$DOT_DIR/$f" ~/$f
    else
      ln -sniv "$DOT_DIR/$f" ~/$f
    fi
  done
  ln -s "$DOT_DIR/Brewfile" ~/$Brewfile
else
  echo "cannot cd to $DOT_DIR"
fi

echo -e "  end link dotfiles.\n"

echo "  finished."
