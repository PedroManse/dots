alias gs="git status"
alias gp="git push"
alias ghp="gh repo create --public --push --source . --remote origin"
alias gd="git diff"
alias gpr="gh pr create -B"
alias gbr="git checkout -b"

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
