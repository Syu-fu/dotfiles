#!/bin/bash
if ! hash go >/dev/null; then
echo 'please Install go command'
exit 1
fi
while read -r line
do
go install "$line"
done < pkg/GO
