echo """
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShellNoCC {
    nativeBuildInputs = with pkgs.buildPackages; [ hello ];
}
""" > shell.nix
echo "use nix" > .envrc
