# bun completions
if [ -d "$HOME/.bun" ] ; then
	# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

	# bun
	export BUN_INSTALL="$HOME/.bun"
	export PATH="$PATH:$BUN_INSTALL/bin"
fi

if [ -d "$HOME/.deno" ] ; then
	export DENO_INSTALL="$HOME/.deno"
	export PATH="$PATH:$DENO_INSTALL/bin"
fi

if [ -d "$HOME/.nvm" ] ; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

