# open file on host vim
_nvim_con() {
	abs_path=$(readlink --canonicalize "$@" | sed s'| |\\ |'g)
	$(get_bin_path nvim) --server $NVIM --remote-send "<ESC>:edit $abs_path<CR>"
	exit
}

# start host and open file
_nvim_srv() {
	$(get_bin_path nvim) --listen $HOME/.cache/nvim/$$-server.pipe $@
}

if [ -n "$NVIM" ] ; then
	export EDITOR="_nvim_con"
else
	export EDITOR="_nvim_srv"
fi

_open() {
	path_parts=$(readlink --canonicalize "$@" | sed s'| |\\ |'g | sed 's/:/\t/' )
	file=$(echo "$path_parts" | awk ' { print $1 }' )
	line=$(echo "$path_parts" | awk ' { print $2 }' )

	if [ -n "$line" ] ; then
		# has line number
		if [ -n "$NVIM" ] ; then
			$(get_bin_path nvim) --server $NVIM --remote-send "<ESC>:edit $file<CR>:+$line<CR>"
			exit
		else
			$(get_bin_path nvim) --listen $HOME/.cache/nvim/$$-server.pipe $file "+:$line"
		fi
	else
		$EDITOR $file
	fi
}

export VISUAL="$EDITOR"
alias nvim="_open"
