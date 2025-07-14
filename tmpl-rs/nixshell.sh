#! /usr/bin/env bash

write_custom_shell() {
	echo "{
		pkgs ? import <nixpkgs> { },
	}:
	pkgs.mkShellNoCC {
		name = \"dev-shell\";
		packages = with pkgs; [ $* ];
	}
	" > shell.nix
	nixfmt shell.nix
}

write_tmpl_shell() {
	cp $1 ./shell.nix
}

if [ -f "$TMPLRS_DIR/nix-shells/$1.nix" ] ; then
	write_tmpl_shell "$TMPLRS_DIR/nix-shells/$1.nix"
else
	write_custom_shell $@
fi

echo "use nix" > .envrc
if [ git status &> /dev/null ] ; then
	echo ".envrc" >> .gitignore
	echo ".direnv" >> .gitignore
fi

