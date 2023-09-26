abbr -S ..='cd ..'
abbr -S p='cd $HOME/Documents/Projects'

if command -v lsd > /dev/null; then
	alias ls="lsd"
fi

abbr -S nv='nvim'
abbr -S g='git'
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

abbr -S copypath='pwd | tr -d "\n" | xsel --clipboard --input'
abbr -S lock='i3lock -i ~/.config/i3/wallpaper_lock.png && sleep 1'
abbr -S myip="ip -4 a show wlp0s20f3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"
