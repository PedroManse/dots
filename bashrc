#! /bin/sh
if [ -f ~/.shenv.sh ] ; then
	. ~/.shenv.sh
fi

alias nvim="nvim -n"
alias svi="sudo nvim -u $HOME/.config/nvim/init.vim"
alias tmod="nvim $HOME/.shrc.sh; source $HOME/.shrc.sh"
alias ref="source $HOME/.shrc.sh"
alias vmod="nvim -c 'edit \$MYVIMRC'"
alias cat="$HOME/.cargo/bin/bat"
alias ls="$HOME/.cargo/bin/eza -h"
alias hq="$HOME/.cargo/bin/htmlq"
alias ..="cd .."
alias ...="cd ../.."
alias _="nvim $HOME/_"
alias py10="/bin/python3.10"
alias flog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%G?- %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias sqli="sqlite3 --header --nullvalue '<{nil}>' --column"

export GPG_TTY=$(tty)
export PSQL_EDITOR="/bin/nvim -n -u $HOME/.vimrc"

alias killJobs="for i in \$(jobs -p | sed 's/[-+]//' | awk '{print \$2}')
do
	kill \$i
done"

if [ -d "$DEVAPS" ] ; then
	export PATH="$DEVAPS/bin:$PATH"
fi

if [ -d "$HOME/.zig" ] ; then
	export PATH="$PATH:$HOME/.zig"
fi

if [ -d "$HOME/.cargo" ] ; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi

if [ -d "$HOME/.deno" ] ; then
	export DENO_INSTALL="$HOME/.deno"
	export PATH="$PATH:$DENO_INSTALL/bin"
fi

if [ -d "/usr/lib/go-1.21/bin" ] ; then
	export PATH="$PATH:/usr/lib/go-1.21/bin"
fi

export ZEN="true"
export BAT_THEME="zenburn"

#lias node="screen -R"
alias grep="grep --color=always -rn"
screenat() {
	back=$(pwd)
	cd $1
	if [[ $WINDOW = "" ]]
	then
		screen
		cd $back
	else
		echo "already in GNU screen"
	fi
}

alias old="screenat $HOME/code/nosso-grupo/PiaCheia/servidor/"
alias clock="screenat $HOME/working/clock/"
alias bot="screenat $HOME/working/go-wabot"

alias SetCapPort="sudo setcap CAP_NET_BIND_SERVICE+pei"

alias gs="git status"
alias gp="git push"
alias gd="git diff"

alias col_reset="echo -ne '\x1b[0m'"
alias col_nc="echo -ne '\x1b[38;2;255;255;255m'"
alias col_red="echo -ne '\x1b[31m'"
alias col_green="echo -ne '\x1b[32m'"
alias col_bold="echo -ne '\x1b[1m'"
alias col_underline="echo -ne '\x1b[4m'"
alias col_blink="echo -ne '\x1b[5m'"
alias col_reverse="echo -ne '\x1b[7m'"
alias er='echo -ne $?'

export GOPATH=$HOME
export TERM=xterm-256color
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

if [[ $COMPUTER_NAME == "" ]] ; then
	if [ -f /etc/hostname ] ; then
		COMPUTER_NAME=$(cat /etc/hostname)
	else
		COMPUTER_NAME="unnamed computer"
	fi
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
		export BROWSER=firefox
	fi
fi

format_dir() {
	thisdir=$1
	if fdir=$(echo $thisdir | socat - UNIX-CONNECT:/tmp/fpwd-rs.sock 2> /dev/null) ; then
		echo $fdir
	else
		if fdir=$(PWD=$thisdir "pwd-rs") ; then
			echo $fdir
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
	fdir=$(format_dir $PWD)
	PS="${fdir}$(col_reset)"

	if [[ $e != '0' ]] ; then
		PS="${PS} [$(col_bold)$(col_underline)$(col_reverse)$(col_red)$e$(col_reset)]"
	fi

	PS="${PS}$(gs2)"

	if [ ! -z $COMPUTER_NAME ] ; then
		PS="$COMPUTER_NAME: ${PS}"
	fi

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

rcom() {
	file=$1
	out=$2

	if ! [[ "$file" =~ ^.*\.rs$ ]] ; then
		file="$file.rs"
	fi

	if [ "$out" = "" ] ; then
		out=${file%.rs}
	fi

	t1=$(date +%s.%N)
	rustc -v -C opt-level=2 -C prefer-dynamic $file -o $out
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

# bun completions
if [ -d "$HOME/.bun" ] ; then
	# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

	# bun
	export BUN_INSTALL="$HOME/.bun"
	export PATH="$PATH:$BUN_INSTALL/bin"
fi

function blt() {
	dvc=$1
	case $dvc in
		30|q30|Q30)
			dvc="E8:EE:CC:6F:35:FE"
		;;
		uwu)
			dvc="5D:E2:D1:57:82:0A"
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

function frink() {
	from=$('echo' $1 | 'sed' "s/ /+/")
	to=$('echo' $2 | 'sed' "s/ /+/")
	'curl' -s "http://frinklang.org/fsp/frink.fsp?fromVal=${from}&toVal=${to}" > /tmp/frink
	'grep' "results" /tmp/frink | 'sed' "s/<A NAME=results>\\(.*\\)<\\/A>/\\1/"
}

function mail() {
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

function serve() {
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
