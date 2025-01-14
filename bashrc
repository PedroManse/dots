#! /bin/sh

if [ -z "$COMPUTER_NAME" ] ; then
	if [ -f /etc/hostname ] ; then
		COMPUTER_NAME=$(cat /etc/hostname)
	else
		COMPUTER_NAME="unnamed computer"
	fi
fi

# computer-specific config
if [ -f ~/.shenv.sh ] ; then
	. ~/.shenv.sh
fi

[ ! -f /bin/bash ]
export FHS=$?

bin () {
	if [ $FHS = 1 ] ; then
		"/bin/$1" ${@:2}
	else
		"/run/current-system/sw/bin/$1" ${@:2}
	fi
}

# if on neovim terminal, open file in neovim instance
nvim() {
	if [ -n "$NVIM" ] ; then
		bin nvim -u $HOME/.config/nvim/init.lua --server $NVIM --remote-send "<ESC>:e $1<CR>"
		exit
	else
		bin nvim -n --listen "${HOME}/.cache/nvim/$$-server.pipe" $@
	fi
}

# discover jira ticket by git branch
issue() {
	branch=$(git b | filte ^'*' | sed 's/* [A-Z]\+-\([0-9]*\).*/\1/')
	if [ $1 ] ; then
		jira issue view $1 | bin cat
	else
		jira issue view $branch | bin cat
	fi
}

export GPG_TTY=$(tty)
export PSQL_EDITOR="bin nvim -n -u $HOME/.vimrc"
export ZEN="true"
export BAT_THEME="zenburn"
export GOPATH=$HOME
export TERM=xterm-256color
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

if [ -d "$DEVAPS" ] ; then
	export PATH="$DEVAPS/bin:$PATH"
fi

if [ -d "$HOME/.zig" ] ; then
	export PATH="$PATH:$HOME/.zig"
fi

if [ -d "$HOME/.cargo" ] ; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi

if [ -d "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/" ] ; then
	export PATH="$PATH:$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin"
fi


if [ -d "$HOME/.deno" ] ; then
	export DENO_INSTALL="$HOME/.deno"
	export PATH="$PATH:$DENO_INSTALL/bin"
fi

# bun completions
if [ -d "$HOME/.bun" ] ; then
	# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

	# bun
	export BUN_INSTALL="$HOME/.bun"
	export PATH="$PATH:$BUN_INSTALL/bin"
fi


if [ -d "/usr/lib/go-1.21/bin" ] ; then
	export PATH="$PATH:/usr/lib/go-1.21/bin"
fi

if [ -d "$HOME/.nvm" ] ; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

export TTY=$(tty)
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]] ; then
	export INWSL="true"
	export BROWSER=wslview
else
	if [[ "$TTY" =~ .*tty.* ]] ; then
		export INTTY="true"
		export BROWSER=w3m
	else
		export INTTY=""
		export BROWSER=open
	fi
fi


alias SetCapPort="sudo setcap CAP_NET_BIND_SERVICE+pei"

# git/github
alias gs="git status"
alias gp="git push"
alias gd="git diff"
alias gpr="gh pr create -B"
alias gbr="git checkout -b"

# colors
alias col_reset="echo -ne '\x1b[0m'"
alias col_nc="echo -ne '\x1b[38;2;255;255;255m'"
alias col_red="echo -ne '\x1b[31m'"
alias col_green="echo -ne '\x1b[32m'"
alias col_bold="echo -ne '\x1b[1m'"
alias col_underline="echo -ne '\x1b[4m'"
alias col_blink="echo -ne '\x1b[5m'"
alias col_reverse="echo -ne '\x1b[7m'"

alias killJobs="jobs -p | xargs kill"
alias svi="sudo nvim -u $HOME/.config/nvim/init.lua"
alias tmod="nvim $HOME/.shrc.sh; source $HOME/.shrc.sh"
alias ref="source $HOME/.shrc.sh"
alias vmod="nvim $HOME/.config/nvim/init.lua"
alias cat="$HOME/.cargo/bin/bat"
alias ocat="bin cat"
alias ls="$HOME/.cargo/bin/eza -h"
alias hq="$HOME/.cargo/bin/htmlq"
alias ..="cd .."
alias ...="cd ../.."
alias _="nvim $HOME/_"
alias py10="bin python3.10"
alias flog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%G?- %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias sqli="sqlite3 --header --nullvalue '<{nil}>' --column"

format_dir() {
	thisdir=$1
	# if fpwd-daemon is running, use it
	fdir=$(echo $thisdir | socat - UNIX-CONNECT:/tmp/fpwd-rs.sock 2> /dev/null)
	if [ $? = 0 ] ; then
		echo $fdir
	else
		# else, try pwd-rs
		if fdir=$(PWD=$thisdir "pwd-rs") ; then
			echo $fdir
		# else, just don't format path
		else
			echo $thisdir
		fi
	fi
}

# prompt_command in PS1 instead of PROMPT so <C-l> doesn't remove it
export PS1=""
export PS0=""
PROMPT_COMMAND=prompt_command
prompt_command() {
	e=$?
	# print formatted working path
	fdir=$(format_dir $PWD)
	PS="${fdir}$(col_reset)"

	# in case of error, show code
	if [[ $e != '0' ]] ; then
		PS="${PS} [$(col_bold)$(col_underline)$(col_reverse)$(col_red)$e$(col_reset)]"
	fi

	# show git status
	PS="${PS}$(gs2)"

	# show computer name if it's not "."
	if [ -n "$COMPUTER_NAME" -a "$COMPUTER_NAME" != "." ] ; then
		PS="$COMPUTER_NAME: ${PS}"
	fi

	# pushd/popd list
	dirlist=$(dirs)
	dircount=$(echo "$dirlist" | wc -w)
	stack=$(($dircount))
	comdirs=""
	for i in $(seq 2 $stack); do
		d='$'
		d+="$i"
		thisdir=$(echo $dirlist | awk "{printf $d }")
		thisdir=$(format_dir $thisdir)
		comdirs+=$thisdir
		comdirs+="$(col_reset) | "
	done
	if [ ! "$comdirs" = '' ] ; then
		PS="${PS} (${comdirs% | })"
	fi

	export PS1="${PS}\nλ"
}

ccom() {
	file=$1
	out=$2
	flags="$3 "
	defaultflags="-O3 -Wall -Wextra -Werror -Wpedantic -Wno-error=pedantic -std=c2x"

	if ! [[ "$file" =~ ^.*\.c$ ]] ; then
		file="$file.c"
	fi

	if [ "$out" = "" ] ; then
		out=${file%.c}
	fi

	t1=$(date +%s.%N)

	if [ -f "./.build" ] ; then
		bcmd=$(cat .build)
		eval "$bcmd"
	else
		cc -o $out $defaultflags $flags $file
	fi

	if [ $? = 0 ] ; then
		t2=$(date +%s.%N)
		elapsed=$(python -c "
e = ($t2-$t1)
if e > 1:
	print(f'{round(e, 3)}s')
else:
	print(f'{int(e*1000)}ms')")
		echo "Compiled $file -> $(col_green)*$out$(col_reset) in ${elapsed}"
	fi
}

cloneat() {
	repo=$1
	author=$2
	todir=$3
	if [[ -d $todir ]]; then
		back=$(pwd)
		git pull
		cd $back
		return
	fi

	if [[ $todir = "" ]]; then
		todir=$repo
	fi

	if [[ $author = "" ]]; then
		author="pedromanse"
	fi

	git clone "https://github.com/$author/$repo" "$todir"
}

blt() {
	dvc=$1
	case $dvc in
		30|q30|Q30)
			dvc="E8:EE:CC:6F:35:FE"
		;;
		bug)
			dvc="9C:19:C2:16:86:55"
		;;
	esac
	act=$2
	case $act in
		"on")
			echo "connect $dvc" | bluetoothctl
		;;
		"off")
			echo "disconnect $dvc" | bluetoothctl
		;;
	esac
}

frink() {
	from=$('echo' $1 | 'sed' "s/ /+/")
	to=$('echo' $2 | 'sed' "s/ /+/")
	'curl' -s "http://frinklang.org/fsp/frink.fsp?fromVal=${from}&toVal=${to}" > /tmp/frink
	'grep' "results" /tmp/frink | 'sed' "s/<A NAME=results>\\(.*\\)<\\/A>/\\1/"
}

mail() {
	if
		[ -z "$EMAIL_SERVER" ] ||
		[ -z "$EMAIL_SERVER_PORT" ] ||
		[ -z "$EMAIL_NAME" ] ||
		[ -z "$EMAIL_SENDER" ] ; then
		echo "email service not set by dots/setup.sh"
		echo "missing one or more of [ EMAIL_SERVER, \
EMAIL_SERVER_PORT, EMAIL_NAME, EMAIL_SENDER ] env vars"
		return 1
	fi
	local RESET=$(  printf "\x1b[0m")
	local REVERSE=$(printf "\x1b[7m")
	local YELW=$(printf '\x1b[1;93m')
	local CYAN=$(printf '\x1b[1;96m')

	if [ "$EMAIL_NOECHO" = "" ] ; then
		prt=echo
	else
		prt=true
	fi

	export EMAIL_TO=$1
	export EMAIL_SUBJ=$2
	if [ "$EMAIL_SUBJ" = "" ] || [ "$EMAIL_TO" = "" ] ; then
		$prt 'TO ($1) and SUBJ ($2) variables must be set'
		return 1
	fi

	if [ "$TEXT" = "" ] ; then
		$prt "you are logged in as <${CYAN}${EMAIL_SENDER}${RESET}>"
		$prt "type your message to <${YELW}${EMAIL_TO}${RESET}>"
		$prt -e "Press ${REVERSE}<C-d>${RESET} to send  ${REVERSE}<C-c>${RESET} to cancel\n"
		export EMAIL_TEXT=$(cat /dev/stdin)
		$prt ""
	else
		export EMAIL_TEXT=$TEXT
	fi
	read -s -e -p "<${CYAN}${EMAIL_SENDER}${RESET}> password: " EMAIL_PASSWORD

	EMAIL_PASSWORD=$EMAIL_PASSWORD python3 "$DEVAPS/sendmail.py"
}

serve() {
	port=$1
	dir=$2
	if [ "$port" = "" ] ; then
		port="8000"
	fi
	if [ "$dir"  = "" ] ; then
		dir="."
	fi
	python3 -m http.server $port -d $dir -p "HTTP/1.1"
}

complete -cf doas
complete -F _command doas
