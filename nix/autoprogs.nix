dir: with builtins; let
	files_names = attrNames (readDir dir);
	# filter (fl: nixpkgs.lib.strings.hasSuffix ".nix")
	progs_names = filter (fl: true) (files_names);
	progs_vals = map (fl: {
		name = replaceStrings [".nix"] [""] fl;
		value = import (dir + ("/"+fl));
	}) (progs_names);
in listToAttrs progs_vals
