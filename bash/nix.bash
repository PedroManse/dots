alias nix-switch="sudo nixos-rebuild switch"

nix-clean() {
	nix-collect-garbage --delete-old
	sudo nix-collect-garbage -d
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

__nix_edit_complete() {
	if [ ${#COMP_WORDS[@]} -gt 3 ] ; then
		return
	fi

	if [ "${3%s}" = "prog" ] ; then
		CR=""
		for path in "$DOTS"/nix/programs/*.nix ; do
			file=$(basename "$path")
			CR="$CR ${file%.nix}"
		done
		COMPREPLY=($(compgen -W "$CR" "${COMP_WORDS[2]}" ))
	else
		COMPREPLY=($(compgen -W "sys home progs" "${COMP_WORDS[1]}" ))
	fi
}
complete -F __nix_edit_complete "nix-edit"

alias nix-ehome="\$EDITOR \$DOTS/nix/home.nix"
alias nix-esys="\$EDITOR \$DOTS/nix/configuration.nix"

