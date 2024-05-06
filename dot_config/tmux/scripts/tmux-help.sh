#!/bin/bash

# tmux popupでbat実行
tmux popup -w 80% -h 80% -x 10% -y 10% 'bat --plain ~/.config/tmux/scripts/tmux-help.md'
