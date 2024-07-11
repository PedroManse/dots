from sys import argv
from os import system as exec, chdir
def CMD(cmd):
	print(f"[CMD]: {cmd}")
	exec(cmd)

argv.pop(0) # path of script
projname = argv.pop(0)
crates: list[tuple[str, list[str]]] = []

for arg in argv:
	if arg.startswith('-'):
		crates[-1][1].append(arg[1:]) # if this failed; check if you named your project
	else:
		crates.append((arg, []))

CMD(f"cargo new --bin {projname}")
chdir(projname)
for (crate, features) in crates:
	if features:
		CMD(f"cargo add {crate} --features {' '.join(features)}")
	else:
		CMD(f"cargo add {crate}")

with open(".gitignore", "w") as f:
    f.write("target")
