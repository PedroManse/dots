#! /usr/bin/env bash

echo "{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShellNoCC {
  name = \"dev-shell\";
  packages = with pkgs; [ $* ];
}
" > shell.nix
echo "use nix" > .envrc
if [ git status &> /dev/null ] ; then
  echo ".direnv" >> .gitignore
fi
nixfmt shell.nix
