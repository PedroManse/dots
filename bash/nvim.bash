_nvim_con() {
	abs_path=$(readlink --canonicalize "$@" | sed s'| |\\ |'g)
	$(get_bin_path nvim) --server $NVIM --remote-send "<ESC>:edit $abs_path<CR>"
	exit
}

if [ -n "$NVIM" ] ; then
	export EDITOR="_nvim_con"
else
	export EDITOR="$(get_bin_path nvim) --listen $HOME/.cache/nvim/$$-server.pipe"
fi
alias nvim="$EDITOR"
