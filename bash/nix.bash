alias nix-switch="sudo nixos-rebuild switch"

nix-clean() {
	sudo nix-collect-garbage --delete-old
	nix-collect-garbage --delete-old
}

nix-edit() {
	case $1 in
	"progs" | "prog")
		if [ -z "$2" ] ; then
			$EDITOR "$DOTS/nix/programs/" "$DOTS/nix/home.nix"
		else
			$EDITOR "$DOTS/nix/programs/$2.nix"
		fi
		;;
	"home")
			$EDITOR "$DOTS/nix/home.nix"
		;;
	"sys")
			$EDITOR "$DOTS/nix/configuration.nix"
		;;
	* )
		echo "
commands:
	prog [program]
	home
	sys"
		;;
	esac
}

__compl_nix_edit() {
	COMPREPLY=(
		$(compl $DOTS/completions/nix-edit.compl ${COMP_WORDS[@]:1})
	)
}
complete -F __compl_nix_edit "nix-edit"

function __compl_tmpl() {
	COMPREPLY=(
		$(compl $DOTS/completions/tmpl.compl ${COMP_WORDS[@]:1})
	)
}
complete -F __compl_tmpl "tmpl"
