{dir, pkgs}: with builtins; let
	files_names = attrNames (readDir dir);
	progs_names = filter (fl: pkgs.lib.strings.hasSuffix ".nix" fl) (files_names);
	progs_vals = map (fl: {
		name = replaceStrings [".nix"] [""] fl;
		value = import (dir + ("/"+fl));
	}) (progs_names);
in listToAttrs progs_vals
