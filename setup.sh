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

#TODO use rustup and cargo to install bat and eza

apps="neovim unzip golang-go curl"
for app in $apps ; do
	if [[ $(command -v $app) || $(dpkg -s $app 2> /dev/null) ]] ; then : ; else
		read -e -p "download $app? [y/N]>" -n 1 usi
		if [[ $usi == "y" ]] ; then
			install $app
		fi
	fi
done

if [ ! -d "$HOME/.cargo" ] ; then
		read -e -p "download rustup? [y/N]>" -n 1 usi
		if [[ $usi == "y" ]] ; then
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		fi
fi

if [ -d "$HOME/.cargo" ] ; then
	if [ ! -f "$HOME/.cargo/bin/delta" ] ; then
		cargo install git-delta
	fi

	cargoapps="eza bat btm"
	for app in $cargoapps ; do
		if [ -f "$HOME/.cargo/bin/$app" ] ; then : ; else
			read -e -p "download $app? [y/N]>" -n 1 usi
			if [[ $usi == "y" ]] ; then
				cargo install $app
			fi
		fi
	done
fi


# get bun
if [[ ! $(command -v bun) ]] ; then
	read -e -p "download bun? [y/N]>" -n 1 usi
	if [[ $usi == "y" ]] ; then
		curl -fsSL https://bun.sh/install | bash &> /dev/null &
		jbs="$jbs $!"
	fi
fi

# setup config
echo "setup .vimrc symlink"
ln -sf "$(pwd)/vimrc" ~/.vimrc
echo "setup .screenrc symlink"
ln -sf "$(pwd)/screenrc" ~/.screenrc
echo "setup .gitconfig symlink"
ln -sf "$(pwd)/gitconfig" ~/.gitconfig
echo "setup shrc.sh symlink"
ln -sf "$(pwd)/bashrc" ~/.shrc.sh
echo "setup shenv.sh file"
echo "# this computer's env file" > ~/.shenv.sh
echo "## file generated by dots/setup.sh" >> ~/.shenv.sh

read -e -p "setup email service? [y/N]>" -n 1 usi
if [[ $usi == "y" ]] ; then
	#TODO ping smtp server
	read -e -p "smtp server>" SERVER
	read -e -p "smtp server port>"  PORT
	read -e -p "email name>" NAME
	read -e -p "email user@domain>" SENDER
	#TODO hide password
	echo "export EMAIL_SERVER=\"${SERVER}\""     >> ~/.shenv.sh
	echo "export EMAIL_SERVER_PORT=\"${PORT}\""  >> ~/.shenv.sh
	echo "export EMAIL_NAME=\"${NAME}\""         >> ~/.shenv.sh
	echo "export EMAIL_SENDER=\"${SENDER}\""     >> ~/.shenv.sh
fi

read -e -p "link tmpl-rs files? [y/N]>" -n 1 usi
if [[ $usi == "y" ]] ; then
	if [ "$TMPLRS_DIR" = "" ] ; then
		#TODO: check with user for another dir
		read -e -p "use $HOME/Templates/tmpl-rs as tmpl-rs template dir? [Y/n]>" -n 1 usi
		if [[ $usi == "n" ]] ; then
			read -e -p "set tmpl-rs template dir>" TMPLRS_DIR
		else
			TMPLRS_DIR="$HOME/Templates/tmpl-rs"
		fi
	fi
	if [ -d $TMPLRS_DIR ] ; then
		echo "D"
		read -e -p "Replace current tmpl dir? [Y/n]>" -n 1 usi
		if [[ $usi == "y" ]] ; then
			rm -r $TMPLRS_DIR
		else
			echo exit 1
		fi
	fi
	echo "export TMPLRS_DIR=\"${TMPLRS_DIR}\"" >> ~/.shenv.sh

	ln -sf "$(pwd)/tmpl-rs" "$TMPLRS_DIR"
fi

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
	# get vim-plug
	curl -fsSLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	echo "installed vim-plug"
fi

read -e -p "download vim-plug plugins? [y/N]>" -n 1 usi
if [[ $usi == "y" ]] ; then
	echo "upgrade plugin manager"
	nvim -u "$(pwd)/vimrc" --headless +"PlugUpgrade" +"qa" &> /dev/null
	echo "update plugins"
	nvim -u "$(pwd)/vimrc" --headless +"PlugUpdate"  +"qa" &> /dev/null
	echo "download plugins"
	nvim -u "$(pwd)/vimrc" --headless +"PlugInstall" +"qa" &> /dev/null
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

if [ ! -d "$workdir/devaps" ] ; then
	read -e -p "download github.com/owseiwastaken/devaps? [y/N]>" -n 1 usi
	if [[ $usi == "y" ]] ; then
		echo "cloning to $workdir/devaps"
		cloneat devaps owseiwastaken "$workdir/devaps"
		echo "export DEVAPS=\"${workdir}/devaps\"" >> ~/.shenv.sh
	fi
else
	echo "export DEVAPS=\"${workdir}/devaps\"" >> ~/.shenv.sh
fi

for pid in $jbs; do
	wait $pid
done

cd $back
