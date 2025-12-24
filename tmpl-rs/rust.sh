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
	cargo clippy \$fix \$allow_dirty --all-targets --all-features
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
      run: cargo clippy --all-targets --all-features
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
