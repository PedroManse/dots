alias netup="sudo ifconfig wlp2s0 up"
#alias run="bash run.sh"
alias nvim="/bin/nvim -u ~/.vimrc"

function run {
	if [[ -f run.sh ]] then
		sh ./run.sh $@
	elif [[ -f run.zsh ]] then
		zsh ./run.zsh $@
	elif [[ -f main.go ]] then
		go build main.go $@
	elif [[ -f main.c ]] then;
		gcc main.c $@
	elif [[ -f main.py ]] then
		python3.10 main.py $@
	else
		echo "nothing detected to run"
	fi
}

function rvim {
	if [[ -f config.vim  ]] ;then
		/bin/nvim -u ~/.vimrc -s config.vim $@
	else
		/bin/nvim -u ~/.vimrc $@
	fi
	clear
	zle reset-prompt
}

zle -N rvim
bindkey "^F" rvim

function ccom {
	cc $@ -O3 -Wall -Wextra -Werror -lm -I /home/coder/cutil
}

function fbcomp {
	cc $@ -O3 -Wall -Wextra -Werror -lm -I /home/coder/cutil -I /home/coder/fb/
}

# good Prompt
#$? ~
#λ

# bad Prompt
#PROMPT="%F{red}┌[%f%F{cyan}%m%f%F{red}]─[%f%F{yellow}%D{%H:%M-%d/%m}%f%F{red}]─[%f%F{magenta}%d%f%F{red}]%f"$'\n'"%F{red}└╼%f%F{green}$USER%f%F{yellow}$%f"

# ... \
# \ cancels \n
tty_sts="$(tty 2> /dev/null)"
if [[ $tty_sts =~ "pts" ]] ; then
	# already on gui mode
	#~/py/xid.py -ar -np
else
	echo -n -e '\e[?17;24;224c'
fi

alias batt="acpi | tail -n 1"
alias guimode="sudo /etc/init.d/lightdm start"
alias ctc="py ~/smaller/ctc.py"
alias math="py ~/smaller/do.py"

# projs/*
alias crm="cd ~/util"

# git stuff
alias gp="git push"
alias gs="git status"
alias gcm="git commit -m"
alias gu="git fetch --prune ; git pull"
alias gd="git diff"
alias ga="git add"
alias Bgs="~/devaps/bin/gs"
# git line count
alias glc="for i in $(git 'ls-files'); do /bin/cat \$i >> .a.o; done; wc -l .a.o; rm .a.o"

#w3m
alias sb="w3m search.brave.com"

alias dos2unix="sed 's/$//'"
alias unix2dos="sed 's/$//'"

# RAM
alias ttv="sudo vmtouch -tv /usr/local/go/bin/go ;\
sudo vmtouch -tv /usr/bin/nvim ;\
sudo vmtouch -tv ~/util/*.py ;\
sudo vmtouch -tv /usr/bin/python3.10 ;\
sudo vmtouch -tv /usr/local/bin/python3.11 ;\
sudo vmtouch -tv ~/.vimrc ;\
sudo vmtouch -tv /bin/x86_64-linux-gnu-gcc-10 ;\
"

alias vtv="\
ttv ;\
sudo vmtouch -tv /opt/brave.com/brave/brave ;\
"

#autoload -Uz vcs_info
#precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable

#zstyle ':git:*' formats '(%b)'
#zstyle ':vcs_info:git:*' formats '(%b)'
# tty, $?, dir \n λ

alias py="python3.11"
alias py11="python3.11"
alias py10="python3.10"
alias py9="python3.9"
setopt PROMPT_SUBST
export ttext=$(tty | sed 's/\/dev\/tty//' | sed 's/\/dev\/pts\//X/')
export fttext=$(echo $ttext | py /home/coder/smaller/ttytofunc.py)
PS1="%F{magenta}[\$(echo \$ttext)] "
PS1+="%(?.%F.%F{red}%? )"
PS1+="\$(~/devaps/bin/spwd) "
PS1+="\$(Bgs)"
PS1+="
%F{cyan}√%F{white}"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
function fancy-ctrl-z {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER="fg"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# clock
#RPS1="%F{yellow}%D{%H:%M:%S}"



#TMOUT=1
#TRAPALRM() {
#	zle reset-prompt
#}
# Export PATH$
export PATH=/usr/local/sbin:/usr/sbin:/sbin:$PATH:~/devaps/bin


zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 4
bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history
bindkey $key[left]";3D" backward-word
bindkey $key[right]";3C" forward-word
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Save type history for completion and easier life
HISTFILE=~/.history.zsh
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Useful alias for benchmarking programs
# require install package "time" sudo apt install time
# alias time="/usr/bin/time -f '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'"
# Display last command interminal
#echo -en "\e]2;Parrot Terminal\a"
#preexec () { print -Pn "\e]0;$1 - Parrot Terminal\a" }

# colors
# res = 1680 x 1050

alias dtd="cd ~/dt"
alias ded="cd ~/devaps"
alias gud="cd ~/gutil"
alias SU="\
sudo cp ~/util/util.py /usr/local/lib/python3.11/util.py ;\
sudo cp ~/util/39util.py /usr/lib/python3.9/util.py ;\
sudo cp ~/util/310util.py /usr/lib/python3.10/util.py ;\
sudo cp ~/util/__pycache__/util.cpython-311.pyc /usr/local/lib/python3.11/__pycache__/util.cpython-311.pyc"

# bluetooth
alias blt="bluetoothctl"
alias hsoff="echo 'disconnect' | bluetoothctl"
alias hson="echo 'connect 9C:19:C2:16:86:55' | bluetoothctl"
alias mbon="echo 'connect 25:61:61:D2:40:77' | bluetoothctl"
alias mboff="echo 'disconnect 25:61:61:D2:40:77' | bluetoothctl"


alias etouch="~/smaller/touch.py 1"
alias dtouch="~/smaller/touch.py 0"
# golang version in /bin
alias touchp="~/Documents/py/touch.py"
alias StalkerKill="pkill XR_3DA.exe"
alias ytdown="~/Documents/py/ytdown.py"
alias netspeed="speedtest-cli"
alias ...="cd ../.."
alias ..="cd .."
alias stt="~/Documents/py/stt.py"
alias clock="~/smaller/iclock.py"
alias oclock="~/smaller/clock.py"
alias tclock="sudo /home/coder/fb/examples/bin/clock -r 45 -y m -r 30 -x m --loop &"
alias tbat="sudo /home/coder/fb/examples/bin/vbat -l 10,30 -t 650,1320 --loop &"
alias vclock="sudo /home/coder/fb/examples/bin/clock"
alias clk="~/smaller/clock.py --once"
alias todo="~/smaller/todos.py"
alias to=todo
alias ls="exa"
alias mkf="~/util/mkf.py "
alias ref="source ~/.zshrc"
alias util="~/util/util.py"

#terminal mod
# zsh mod
alias tmod="nvim ~/.zshrc ; ref"
# (my) pwd mod
alias dmod="nvim ~/.config/spwd.xmp"
# vim mod
alias vmod="nvim ~/.vimrc"

# my stuff
alias cal="~/smaller/cal/calendar.py"
alias xt="~/py/xt.py"
alias gc="~/gutil/gc.py"
alias gr="~/gutil/gc.py /run/"

# cmd acts
alias bat="batcat"
alias instl="sudo apt install"
alias aptrm="sudo apt remove"
alias updt="sudo apt update ; sudo apt safe-upgrade ; sudo apt autoremove ; clear" #\
#update the needs to update list install updates, clear useless packs and clear the screen

alias _="nvim /tmp/_.txt"
alias rf="rm -rf"
alias gli="sudo /etc/init.d/lightdm start"
alias gitfetch="onefetch"
alias csteam="steam -no-browser +open steam://open/minigameslist"

# clear
export EDITOR=/bin/nvim
export GOROOT=/usr/local/go/
export PATH=$GOROOT/bin:$PATH
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export TERM=xterm-256color
export EMAIL="pedrormanse@gmail.com"
#  TODO TODO TODO TODO TODO TODO TODO
# TODO DON'T UPLOAD THIS SHIT OMFG TODO
#  TODO TODO TODO TODO TODO TODO TODO
export GITHUB_PERSONAL_TOKEN=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
#  TODO TODO TODO TODO TODO TODO TODO
# TODO DON'T UPLOAD THIS SHIT OMFG TODO
#  TODO TODO TODO TODO TODO TODO TODO
#DRI_PRIME=1 glxgears

