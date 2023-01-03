#!/bin/bash
if ! hash pacman >/dev/null; then
echo 'please Install pacman command'
exit 1
fi
while read -r line
do
sudo pacman -S "$line"
done < pkg/PACMAN
