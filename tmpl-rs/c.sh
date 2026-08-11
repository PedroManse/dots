set -eu
proj_name=$1

mkdir "$proj_name"
cd "$proj_name"
cat > Makefile << EOF
build: main

run: build
	main

CC := gcc
CFLAGS := -O3 -Wall -Wextra
EOF

cat > main.c << EOF
#include <stdio.h>

int main(int argc, char *argv[]) {
	printf("Hello, world!\n");
	return 0;
}
EOF
