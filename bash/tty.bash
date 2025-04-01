export TTY=$(tty)
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]] ; then
	export INWSL="true"
	export BROWSER=wslview
else
	if [[ "$TTY" =~ .*tty.* ]] ; then
		export INTTY="true"
		export BROWSER=w3m
	else
		export INTTY=""
		export BROWSER=open
	fi
fi

