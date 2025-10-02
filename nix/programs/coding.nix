let
  fenix = import (fetchTarball "https://github.com/nix-community/fenix/archive/monthly.tar.gz") { };
in
pkgs: with pkgs; [
  # LSPs
  nixd
  bash-language-server
  typescript-language-server
  lua-language-server
  emmet-language-server

  # others
  nixfmt-rfc-style
  shellcheck
  fenix.complete.toolchain
]
