#! /usr/bin/env bash

set -e
proj_name=$1

cargo new --bin "$proj_name"
cd "$proj_name"
echo "target
.direnv
" >> .gitignore
:> "src/lib.rs"

echo "{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShellNoCC {
    nativeBuildInputs = with pkgs.buildPackages; [ ];
}
" > shell.nix
echo "use nix" > .envrc


echo '#! /usr/bin/env bash
if [ "$1" = "--allow-dirty" ] || [ "$2" = "--allow-dirty" ] ; then allow_dirty="--allow-dirty" ; fi
if [ "$1" = "--fix" ] || [ "$2" = "--fix" ] ; then fix="--fix" ; fi

set -ex
cargo build
cargo fmt
cargo clippy $fix $allow_dirty --all-targets --all-features -- \
	-Dclippy::perf \
	-Dclippy::style \
	-Wclippy::pedantic \
	-Aclippy::unnested_or_patterns \
	-Aclippy::wildcard_imports \
	-Aclippy::enum_glob_use \
	-Aclippy::too_many_lines \
	-Aclippy::match_same_arms \
	-Aclippy::unnecessary_wraps \
	-Aclippy::missing_errors_doc
cargo test' > ci.sh

mkdir -p .github/workflows
echo '
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
      run: "cargo clippy --all-targets --all-features -- -Dclippy::perf -Dclippy::style -Wclippy::pedantic -Aclippy::unnested_or_patterns -Aclippy::wildcard_imports -Aclippy::enum_glob_use -Aclippy::too_many_lines -Aclippy::match_same_arms -Aclippy::unnecessary_wraps -Aclippy::missing_errors_doc"
    - name: Test
      run: cargo test
' > .github/workflows/rust.yml

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
