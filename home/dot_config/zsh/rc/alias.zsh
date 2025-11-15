# Modern ls alternative
if command -v lsd >/dev/null 2>&1; then
	alias ls="lsd"
fi

# Safe file operations
alias cp='cp -rip'
alias mv='mv -i'
alias rm='rm -ri'

# GNU tools (macOS)
if command -v ggrep >/dev/null 2>&1; then
	alias grep="ggrep"
fi

if command -v gsed >/dev/null 2>&1; then
	alias sed="gsed"
fi
