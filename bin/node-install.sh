#!/bin/bash
if ! hash npm >/dev/null; then
echo 'please Install npm command'
exit 1
fi
while read -r line
do
sudo npm i -g "$line"
done < pkg/NPM
