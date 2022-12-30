#!/bin/bash
# shellcheck disable=SC2034
# https://zenn.dev/odan/articles/17a86574b724c9
set -eu

{ for i in $(seq 1 10); do /usr/bin/time --format="%e" -o /dev/stdout zsh -i -c exit; done; } > /tmp/zsh-load-time.txt 2> /dev/null
ZSH_LOAD_TIME=$(awk '{ total += $1 } END { print total/NR }' /tmp/zsh-load-time.txt)

{ for i in $(seq 1 10); do /usr/bin/time --format="%e" -o /dev/stdout nvim -c q; done; } > /tmp/nvim-load-time.txt 2> /dev/null
 NVIM_LOAD_TIME=$(awk '{ total += $1 } END { print total/NR }' /tmp/nvim-load-time.txt)

cat << EOJ
[
    {
        "name": "zsh load time",
        "unit": "Second",
        "value": ${ZSH_LOAD_TIME}
    },
    {
        "name": "neovim load time",
        "unit": "Second",
        "value": ${NVIM_LOAD_TIME}
    }
]
EOJ
