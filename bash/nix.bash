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
alias nix-ehome="\$EDITOR \$DOTS/nix/home.nix"
alias nix-esys="\$EDITOR \$DOTS/nix/configuration.nix"

