{ from_dir, to_dir }:
with builtins;
let
  progs_vals = map (fl: {
    name = toString to_dir + fl;
    value = {
      source = "${from_dir}/${fl}";
    };
  }) (attrNames (readDir from_dir));
in
listToAttrs progs_vals
