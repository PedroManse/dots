# DevAps
if [ -d "$DEVAPS" ] ; then
	export PATH="$DEVAPS/bin:$PATH"
fi

# Cargo
if [ -d "$HOME/.cargo" ] ; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi
if [ -d "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/" ] ; then
	export PATH="$PATH:$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin"
fi

# Golang
if [ -d "/usr/lib/go-1.21/bin" ] ; then
	export PATH="$PATH:/usr/lib/go-1.21/bin"
fi

# Zig
if [ -d "$HOME/.zig" ] ; then
	export PATH="$PATH:$HOME/.zig"
fi
export GOPATH=$HOME/.go

# JS/Bun
if [ -d "$HOME/.bun" ] ; then
	export BUN_INSTALL="$HOME/.bun"
	export PATH="$PATH:$BUN_INSTALL/bin"
fi

# JS/Deno
if [ -d "$HOME/.deno" ] ; then
	export DENO_INSTALL="$HOME/.deno"
	export PATH="$PATH:$DENO_INSTALL/bin"
fi

# JS/Node
if [ -d "$HOME/.nvm" ] ; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

