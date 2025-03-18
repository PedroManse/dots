if [ -d "$HOME/.cargo" ] ; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi
if [ -d "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/" ] ; then
	export PATH="$PATH:$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin"
fi

