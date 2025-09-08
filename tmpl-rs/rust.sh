#! /usr/bin/env bash

set -e
proj_name=$1

cargo new --bin "$proj_name"
cd "$proj_name"
cat >> .gitignore << EOF
target
EOF
:> "src/lib.rs"


cat > ci.sh << EOF
#! /usr/bin/env bash
set -e

if [ -n "\$FIX" ] && [ "\$FIX" != "0" ] ; then
	fix="--fix"
fi

if [ -n "\$DIRTY" ] && [ "\$DIRTY" != "0" ] ; then
	allow_dirty="--allow-dirty"
fi


ci() {
	pushd \$1
	set -x

	cargo build
	cargo fmt
	cargo clippy \$fix \$allow_dirty --all-targets --all-features -- \
		-Dclippy::perf \
		-Dclippy::style \
		-Wclippy::pedantic \
		-Aclippy::unnested_or_patterns \
		-Aclippy::wildcard_imports \
		-Aclippy::enum_glob_use \
		-Aclippy::too_many_lines \
		-Aclippy::match_same_arms \
		-Aclippy::unnecessary_wraps \
		-Aclippy::missing_errors_doc \
		-Aclippy::cast_sign_loss \
		-Aclippy::cast_possible_wrap \
		-Aclippy::cast_possible_truncation
	cargo test

	set +x
	popd
}

if [ "\$#" != 0 ] ; then
	for target in "\$@" ; do
		ci \$target
	done
else
	ci .
fi
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
      run: "cargo clippy --all-targets --all-features -- -Dclippy::perf -Dclippy::style -Wclippy::pedantic -Aclippy::unnested_or_patterns -Aclippy::wildcard_imports -Aclippy::enum_glob_use -Aclippy::too_many_lines -Aclippy::match_same_arms -Aclippy::unnecessary_wraps -Aclippy::missing_errors_doc"
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
