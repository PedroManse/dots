alias killJobs="jobs -p | xargs kill"
alias svi="sudo nvim -u $HOME/.config/nvim/init.lua"
alias tmod="nvim $HOME/dots/bashrc; source $HOME/dots/bashrc"
alias ref="source $HOME/dots/bashrc"
alias vmod="nvim $HOME/.config/nvim/init.lua"
alias cat="$(get_bin_path bat)"
alias ocat="$(get_bin_path cat)"
alias ls="$HOME/.cargo/bin/eza -h"
alias hq="$HOME/.cargo/bin/htmlq"
alias ..="cd .."
alias ...="cd ../.."
alias _="nvim $HOME/_"
alias flog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -%G?- %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias sqli="sqlite3 --header --nullvalue '<{nil}>' --column"

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
