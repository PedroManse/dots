#! /bin/bash

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

#default usesudo "sudo"
echo $usesudo
echo $set_usesudo

function setup_install() {
	if ! command -v sudo &> /dev/null; then
		echo "could not find program 'sudo'"
		exit 1
	fi

	if command -v apt &> /dev/null; then
		function install() {
			echo "$usesudo apt install $@"
		}
	elif command -v yum &> /dev/null; then
		function install() {
			echo "$usesudo yum install $@"
		}
	elif command -v dnf &> /dev/null; then
		function install() {
			echo "$usesudo dnf install $@"
		}
	elif command -v pacman &> /dev/null; then
		function install() {
			echo "$usesudo pacman -S $@"
		}
	else
		echo "could not find package manager"
		exit 1
	fi
}

setup_install

install neovim unzip

# get bun
#curl -fsSL https://bun.sh/install | bash
# get vim-plug
#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

