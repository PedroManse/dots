#! /bin/bash
set -e

# go to folder
back=$(pwd)
cd $(dirname "$(realpath $0)")

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

mkdir -p "$workdir"

function setup_install() {
	if ! command -v $asroot &> /dev/null; then
		echo "could not find program '$asroot'"
		exit 1
	fi

	if command -v apt &> /dev/null; then
		echo "Found apt"
		function install() {
			$asroot apt install -y "$@"
		}
	elif command -v yum &> /dev/null; then
		echo "Found yum"
		function install() {
			$asroot yum install "$@"
		}
	elif command -v dnf &> /dev/null; then
		echo "Found dnf"
		function install() {
			$asroot dnf install "$@"
		}
	elif command -v pacman &> /dev/null; then
		echo "Found pacman"
		function install() {
			$asroot pacman -S "$@"
		}
	else
		echo "could not find package manager"
		exit 1
	fi
}

setup_install

apps="neovim unzip golang-go bat exa curl"
for app in $apps ; do
	if [[ ! $(dpkg -s $app) ]] ; then
		read -p "download $app? [y/N]>" -n 1 usi
		if [[ $usi == "y" ]] ; then
			install $app
		fi
	fi
done

# get bun
read -p "download bun? [y/N]>" -n 1 usi
if [[ $usi == "y" ]] ; then
	curl -fsSL https://bun.sh/install | bash &> /dev/null &
	jbs="$jbs $!"
fi

# get vim-plug
curl -fsSLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "installed vim-plug"

# setup config
echo "setup .vimrc symlink"
ln -sf "$(pwd)/vimrc" ~/.vimrc
echo "setup .screenrc symlink"
ln -sf "$(pwd)/screenrc" ~/.screenrc
echo "setup .bashrc symlink"
ln -sf "$(pwd)/bachrd" ~/.shrc.sh

read -p "download vim-plug plugins? [y/N]>" -n 1 usi
if [[ $usi == "y" ]] ; then
	# download plugins
	nvim -u ~/.vimrc --headless +"PlugInstall" +"qa" &> /dev/null &
	jbs="$jbs $!"
fi

# clone or update github repo
cloneat() {
	repo=$1
	author=$2
	todir=$3
	if [[ -d $todir ]]; then
		back=$(pwd)
		git pull
		cd $back
		return
	else
		echo "no such directory $todir"
		exit 1
	fi

	if [[ $todir = "" ]]; then
		todir=$repo
	fi

	if [[ $author = "" ]]; then
		author="pedromanse"
	fi

	git clone "https://github.com/$author/$repo" "$todir" &> /dev/null &
	jbs="$jbs $!"
}

read -p "download github.com/owseiwastaken/devaps? [y/N]>" -n 1 usi
if [[ $usi == "y" ]] ; then
	echo "cloning to $workdir/devaps"
	cloneat devaps owseiwastaken "$workdir/devaps"
fi

for pid in $jbs; do
	wait $pid
done

cd $back
