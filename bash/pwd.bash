format_dir() {
	thisdir=$1
	# if fpwd-daemon is running, use it
	fdir=$(echo $thisdir | socat - UNIX-CONNECT:/run/fpwd-rs.sock 2> /dev/null)
	if [ $? = 0 ] ; then
		echo $fdir
	else
		# else, try pwd-rs
		if fdir=$(PWD=$thisdir "pwd-rs") ; then
			echo $fdir
		# else, just don't format path
		else
			echo $thisdir
		fi
	fi
}

export PS1=""
export PS0=""
PROMPT_COMMAND=prompt_command
prompt_command() {
	e=$?
	# print formatted working path
	fdir=$(format_dir $PWD)
	PS="${fdir}$(col_reset)"

	# in case of error, show code
	if [[ $e != '0' ]] ; then
		PS="${PS} [$(col_bold)$(col_underline)$(col_reverse)$(col_red)$e$(col_reset)]"
	fi

	# show git status
	PS="${PS}$(gs2)"

	# show computer name if it's not "."
	if [ -n "$COMPUTER_NAME" -a "$COMPUTER_NAME" != "." ] ; then
		PS="$COMPUTER_NAME: ${PS}"
	fi

	# pushd/popd list
	dirlist=$(dirs)
	dircount=$(echo "$dirlist" | wc -w)
	stack=$(($dircount))
	comdirs=""
	for i in $(seq 2 $stack); do
		d='$'
		d+="$i"
		thisdir=$(echo $dirlist | awk "{printf $d }")
		thisdir=$(format_dir $thisdir)
		comdirs+=$thisdir
		comdirs+="$(col_reset) | "
	done
	if [ ! "$comdirs" = '' ] ; then
		PS="${PS} (${comdirs% | })"
	fi

	export PS1="${PS}\nλ"
}

