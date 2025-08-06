{ dir, pkgs }:
with builtins;
let
  files = attrNames (readDir dir);
  progs_names = filter (pkgs.lib.strings.hasSuffix ".nix") files;
  progs_vals = map (fl: {
    name = replaceStrings [ ".nix" ] [ "" ] fl;
    value = import (dir + ("/" + fl));
  }) progs_names;
in
listToAttrs progs_vals
