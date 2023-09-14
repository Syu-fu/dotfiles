alias ..='cd ..'
alias p='cd $HOME/Documents/Projects'

if command -v lsd > /dev/null; then
	alias ls="lsd"
fi

alias nv='nvim'
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

alias copypath='pwd | tr -d "\n" | xsel --clipboard --input'
alias lock='i3lock -i ~/.config/i3/wallpaper_lock.png && sleep 1'
alias myip="ip -4 a show wlp0s20f3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"
