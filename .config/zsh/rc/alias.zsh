abbr -S --quieter ..='cd ..'
abbr -S --quieter p='cd $HOME/Documents/Projects'

if command -v lsd > /dev/null; then
	alias ls="lsd"
fi

abbr -S --quieter nv='nvim'
abbr -S --quieter g='git'
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

abbr -S --quieter copypath='pwd | tr -d "\n" | xsel --clipboard --input'
abbr -S --quieter lock='i3lock -i ~/Dropbox/wallpaper.jpg && sleep 1'
abbr -S --quieter myip="ip -4 a show wlp0s20f3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"

abbr import-git-aliases -g --prefix --quieter "git "
