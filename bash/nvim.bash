# open file on host vim
_nvim_con() {
	if [ ! $# = 0 ] ; then
		abs_path=$(readlink --canonicalize "$@" | sed 's| |\\ |g')
		$(get_bin_path nvim) --server "$NVIM" --remote-send "<ESC>:edit $abs_path<CR>"
	else
		$(get_bin_path nvim) --server "$NVIM" --remote-send "<ESC>:enew<CR>"
	fi
	exit
}

# start host and open file
_nvim_srv() {
	$(get_bin_path nvim) --listen "$HOME"/.cache/nvim/$$-server.pipe "$@"
}

if [ -n "$NVIM" ] ; then
	export EDITOR="_nvim_con"
else
	export EDITOR="_nvim_srv"
fi

_open() {
	if [ ! $# = 0 ] ; then
		path_parts=$(readlink --canonicalize "$@" | sed 's| |\\ |g' | sed 's/:/\t/' )
		file=$(echo "$path_parts" | awk ' { print $1 }' )
		line=$(echo "$path_parts" | awk ' { print $2 }' )
	fi

	if [ -n "$line" ] ; then
		# has line number
		if [ -n "$NVIM" ] ; then
			$(get_bin_path nvim) --server "$NVIM" --remote-send "<ESC>:edit $file<CR>:+$line<CR>"
			exit
		else
			$(get_bin_path nvim) --listen "$HOME"/.cache/nvim/$$-server.pipe "$file" "+:$line"
		fi
	else
		$EDITOR "$file"
	fi
}

vim-edit() {
	case $1 in
		"p" | "plug" | "plugin" | "plugins" )
			$EDITOR "$DOTS/nix/programs/neovim.nix"
		;;
		* )
			$EDITOR "$DOTS/nvim/lua/$1.lua"
		;;
	esac
}

function __compl_vim_edit() {
	COMPREPLY=(
		$(compl $DOTS/completions/vim-edit.compl ${COMP_WORDS[@]:1})
	)
}
complete -F __compl_vim_edit "vim-edit"

alias nvim="_open"
