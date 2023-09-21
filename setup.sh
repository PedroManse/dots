#! /bin/bash

set -xe
jbs=""

for arg in "$@"; do
	if [[ $arg == *"="* ]]; then
		export "$arg"
		export "set_$arg"
	else
		export "set_$arg=1"
	fi
done

function default() {
	if [[ ${!1} == "" ]]; then
		export "$1=$2"
	fi
}

default workdir ~/code
default asroot "sudo"

function setup_install() {
	if ! command -v sudo &> /dev/null; then
		echo "could not find program 'sudo'"
		exit 1
	fi

	if command -v apt &> /dev/null; then
		function install() {
			$asroot apt install -y "$@"
		}
	elif command -v yum &> /dev/null; then
		function install() {
			$asroot yum install "$@"
		}
	elif command -v dnf &> /dev/null; then
		function install() {
			$asroot dnf install "$@"
		}
	elif command -v pacman &> /dev/null; then
		function install() {
			$asroot pacman -S "$@"
		}
	else
		echo "could not find package manager"
		exit 1
	fi
}

setup_install

install neovim unzip golang-go bat

# get bun
curl -fsSL https://bun.sh/install | bash &> /dev/null &
jbs="$jbs $!"
# get vim-plug
curl -fsSLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# set pluings + config
cp ./vimrc ~/.vimrc
# download plugins
nvim -u ~/.vimrc --headless +"PlugInstall" +"qa" &> /dev/null &
jbs="$jbs $!"

cp ./screenrc ~/.screenrc
cp ./zshrc ~/.zshrc


# clone or update github repo
cloneat() {
	repo=$1
	author=$2
	todir=$3
	if [[ -d $todir ]]; then
		return
	fi

	if [[ $author = "" ]]; then
		author="pedromanse"
	fi

	git clone "https://github.com/$author/$repo" "$todir" &> /dev/null &
	jbs="$jbs $!"
}

mkdir -p "$workdir"
cloneat devaps owseiwastaken "$workdir/devaps"

for pid in $jbs; do
	wait $pid
done

