alias nvim="/bin/nvim -n -u ~/.vimrc"
alias svi="sudo /bin/nvim -u /home/ow/.vimrc"
alias tmod="nvim ~/.zshrc; source ~/.zshrc"
alias ref="source ~/.zshrc"
alias vmod="nvim ~/.vimrc"
alias ls="/bin/exa"
alias bat="batcat"
alias ..="cd .."
alias ...="cd ../.."
alias _="nvim ~/_"
alias oi="sh ~/_"
alias cb="nvim /tmp/_"
alias py7="/mnt/c/Users/Pedro/AppData/Local/Microsoft/WindowsApps/python.exe"
alias py10="/bin/python3.10"
alias flog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias sqli="sqlite3"
alias browser="/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe"
alias timecard="ssh pedro@192.168.15.129"
#alias node="screen -R"

alias timecardip="echo 192.168.15.129:80"


function gopkg() {
	browser "pkg.go.dev/$1"
}

function gosrch() {
	browser "pkg.go.dev/search?q=$1"
}

function upbatk() {
	while true; do;
		batcat $1;
		read -k1;
	done;
}

function upbats() {
	while true; do;
		batcat $1;
		sleep 1;
	done;
}

function upbatl() {
	while true; do;
		batcat $1;
	done;
}

alias miny="while true; do; sleep 1; clear; ./min ./glpi.api.js ./wa.api.js ./extra.js ./ticketbot.js; done;"

alias SetCapPort="sudo setcap CAP_NET_BIND_SERVICE+pei"
alias todo="~/done/devaps/bin/todos"

alias fgs="~/done/devaps/bin/gs; echo"
alias gs="git status"
alias gcm="git commit -m"
alias gp="git push"
alias gu="git fetch --prune"
alias gd="git diff"

alias todo="cat ~/_"
alias gtd="for i in \`git ls-files\`; do;
todos \$i;
done;"

alias todos="~/done/devaps/bin/todos"
alias nc="echo -ne '\x1b[38;2;255;255;255m'"
function precmd() {
	psvar[2]=$?
}
set -o PROMPT_SUBST
setopt promptsubst
export PS1='$(/home/ow/done/devaps/bin/spwd) $(/home/ow/done/devaps/bin/gs) %2v
λ'


#echo -e "\e[38;2;255;255;0mcrm: remember to turn on the DB, manse\e[38;2;255;255;255m"
#echo -e "\e[38;2;255;255;0mpostgresql: wsl -d Ubuntu_e_cidade -u postgres\e[38;2;255;255;255m"
#function mdb() {
#	if [[ $(sudo service mariadb status) =~ "stop" ]]; then;
#		echo "starting mariadb"
#		sudo service mariadb start
#	fi;
#}

export GOPATH=~
export TWILIO_ACCOUNT_ID="AC4678f85c42655799e213a7dfa4ae9245"
export TWILIO_AUTH_TOKEN="273bc2880bd955c668c0c73749ec0ab2"

export NVM_DIR="$HOME/.nvm"
function nvm() {
	echo "loading nvm"
	source "$NVM_DIR/nvm.sh"
	echo "nvm has been loaded"
}
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GLPI_TOKEN="q2daOKV6ODsPlGog5XY4U8RefWXkCYl0RrG1WzxN"

export BROWSER=wslview

cd ~/working
#cd wa-bot
cd ./clock
export SCREENDIR=$HOME/.screen
[ -d $SCREENDIR ] || mkdir -p -m 700 $SCREENDIR
export TERM=xterm-256color
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
