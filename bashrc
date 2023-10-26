#! /bin/sh


alias nvim="/bin/nvim -n -u $HOME/.vimrc"
alias svi="sudo /bin/nvim -u $HOME/.vimrc"
alias tmod="nvim $HOME/.shrc.sh; source $HOME/.shrc.sh"
alias ref="source $HOME/.shrc.sh"
alias vmod="nvim $HOME/.vimrc"
alias ls="/bin/exa"
alias bat="batcat"
alias ..="cd .."
alias ...="cd ../.."
alias _="nvim $HOME/_"
alias py10="/bin/python3.10"
alias flog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias sqli="sqlite3"

alias killJobs="for i in \$(jobs -p | sed 's/[-+]//' | awk '{print \$2}')
do
	kill \$i
done"


#alias node="screen -R"
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
alias gu="git fetch --prune"
alias gd="git diff"

#alias todos="$HOME/code/devaps/bin/todos"
alias nc="echo -ne '\x1b[38;2;255;255;255m'"
alias red="echo -ne '\x1b[38;2;255;100;100m'"
alias green="echo -ne '\x1b[38;2;0;255;0m'"
alias er='echo -ne $?'

PROMPT_COMMAND=prompt_command # Function to generate PS1 after CMDs
prompt_command() {
	e=$?
	PS="$($HOME/code/devaps/bin/spwd)"

	if [[ $e != '0' ]] ; then
		PS="${PS} [$(red)$e$(nc)]"
	fi

	if [ -d ./.git ] ; then
		PS="${PS} $($HOME/code/devaps/bin/gs)"
	fi

	echo -e $PS
}
export PS1="λ"
export PS0=""


export GOPATH=$HOME

export BROWSER=wslview

export SCREENDIR=$HOME/.screen
[ -d $SCREENDIR ] || mkdir -p -m 700 $SCREENDIR
export TERM=xterm-256color

export EDITOR="nvim"

ccom() {
	file=$1
	out=$2
	flags="$3 "
	defaultflags="-O3 -Wall -Wextra -Werror -Wpedantic -Wno-error=pedantic -std=c2x"

	if ! [[ "$file" =~ '^.*\.c$' ]] ; then
		file="$file.c"
	fi

	first=$(echo "$flags" | cut -f -1 -d ' ')
	if [[ $first = "-cus" ]] ; then
		flags=$(echo "$flags" | cut -f 2- -d ' ')
		defaultflags=""
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
		echo "Compiled $file -> $(green)*$out$(nc) in ${elapsed}"
	fi
}

# bun completions
if [ -f "$HOME/.bun" ]
then
	[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

	# bun
	export BUN_INSTALL="$HOME/.bun"
	export PATH="$BUN_INSTALL/bin:$PATH"
fi

#TODO: add $HOME/code/*/bin to PATH:%
