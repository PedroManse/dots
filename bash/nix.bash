alias nix-switch="sudo nixos-rebuild switch"
alias nix-build="nixos-rebuild build"
nix-clean() {
	nix-collect-garbage --delete-old
	sudo nix-collect-garbage -d
}
nix-edit() {
	case $1 in
	"progs" | "prog")
		if [ -z "$2" ] ; then
			$EDITOR "$HOME/dots/nix/programs/" "$HOME/dots/nix/home.nix"
		else
			$EDITOR "$HOME/dots/nix/programs/$2.nix"
		fi
		;;
	"home")
			$EDITOR "$HOME/dots/nix/home.nix"
		;;
	"sys")
			$EDITOR "$HOME/dots/nix/configuration.nix"
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
alias nix-ehome="\$EDITOR \$HOME/dots/nix/home.nix"
alias nix-esys="\$EDITOR \$HOME/dots/nix/configuration.nix"

