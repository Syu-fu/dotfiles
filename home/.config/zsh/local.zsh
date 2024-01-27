
function pkill() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
	fi
}

function docker-attach() {
	local cid
	cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

function zsh-startuptime() {
	local total_msec=0
	local msec
	local i
	for i in $(seq 1 10); do
		msec=$((TIMEFMT='%mE'; time zsh -i -c exit) 2>/dev/stdout >/dev/null)
		msec=$(echo $msec | tr -d "ms")
		echo "${(l:2:)i}: ${msec} [ms]"
		total_msec=$(( $total_msec + $msec ))
	done
	local average_msec
	average_msec=$(( ${total_msec} / 10 ))
	echo "\naverage: ${average_msec} [ms]"
}

# use ipv4 in nodejs
export NODE_OPTIONS=--dns-result-order=ipv4first

# TO IBIS JAPAN PROJECT
eval "$(pyenv init -)"
