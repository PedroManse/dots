#! /usr/bin/env bash

set -e
proj_name=$1

cargo new --bin "$proj_name"
cd "$proj_name"
cat >> .gitignore << EOF
target
EOF

cat >> Cargo.toml << EOF
[lints.clippy]
perf = { level = "deny", priority = -1 }
style = { level = "deny", priority = -1 }
pedantic = { level = "deny", priority = -1 }
unwrap-used = "warn"
missing-errors-doc = "warn"
EOF

cat >> clippy.toml << EOF
allow-expect-in-tests = true
allow-exact-repetitions = false
check-private-items = true
EOF

cat > Makefile << EOF
.PHONY: build ci

build:
	cargo build

ci: build
	cargo fmt
	cargo clippy --all-targets
	cargo test
EOF

mkdir -p .github/workflows
cat > .github/rust.yml << EOF
name: Rust

on:
  pull_request:
    branches: [ "master" ]

env:
  CARGO_TERM_COLOR: always

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Build
      run: cargo build
    - name: Format
      run: cargo fmt --check
    - name: Lint
      run: cargo clippy --all-targets
    - name: Test
      run: cargo test
EOF

log=$(mktemp)
crate_name=""
echo "create project $proj_name" > "$log"
features=""
for arg in "${@:2}" "" ; do
	if [[ "$arg" =~ "-" ]] ; then
		features="$features${arg#-} "
	elif [ -z "$crate_name" ] ; then
		# first crate
		# consume last " "
		crate_name=$arg
	else
		if [ -z "$features" ] ; then
			echo "add $crate_name with default features" >> "$log"
			cargo add "$crate_name"
		else
			echo "add $crate_name with [ $features]" >> "$log"
			cargo add "$crate_name" --features "$features"
		fi
		features=""
		crate_name=$arg
	fi
done

cat "$log"
rm "$log"
