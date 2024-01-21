#!/bin/bash

BROWSER_COMMAND="$1"
URL_FILE="$2"

if [ -z "$BROWSER_COMMAND" ] || [ -z "$URL_FILE" ]; then
	echo "Usage: $0 <browser_command> <url_file>"
	exit 1
fi

if [ ! -f "$URL_FILE" ]; then
	echo "Error: $URL_FILE not exists"
	exit 1
fi

while IFS= read -r line; do
	$BROWSER_COMMAND "$line"
done < "$URL_FILE"
