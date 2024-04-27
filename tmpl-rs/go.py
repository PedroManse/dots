from sys import argv
from os import system as exec, chdir, mkdir, path
def CMD(cmd):
    print(f"[CMD]: {cmd}")
    exec(cmd)

def make_dir(dirname):
    print(f"[INFO]: create directory {dirname}")
    mkdir(dirname)

def make_file(filename, packagename, content=""):
    print(f"[INFO]: create file {filename}")
    if not filename.endswith('.go'):
        filename += ".go"
    file = open(filename, 'w')
    file.write(f"package {packagename}\n")
    file.write(content)
    file.close()

def make_module(modname: str, files: list[str]):
    make_dir(modname)
    for file in files:
        make_file(path.join(modname, file), modname)

argv.pop(0) # path of script
projname = argv.pop(0)


modules: list[tuple[str, list[str]]] = []

for arg in argv:
    if arg.startswith('-'):
        modules[-1][1].append(arg[1:]) # if this failed; check if you named your project
    else:
        modules.append((arg, []))

#tmpl go wabot-v2 toml -parse graph -dot protocol -parse utils -lib script -parse

make_dir(projname)
chdir(projname)
import_modules = '\n'.join([
    f"\t//\"{projname}/{module[0]}\"" for module in modules
])
make_file("main.go", "main", """
import (
\t"fmt"
%s
)

func main() {
\tfmt.Println("Hello, world!")
}

""" % import_modules)
CMD(f"go mod init {projname}")
CMD(f"go mod tidy")

for (mod, files) in modules:
    make_module(mod, files)

CMD("git init")
