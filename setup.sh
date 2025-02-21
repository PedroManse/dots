#! /bin/bash
set -e

# go to folder
back=$(pwd)
cd $(dirname "$(realpath $0)")

jbs=""

function default() {
	if [[ ${!1} == "" ]]; then
		export "$1=$2"
	fi
}

default workdir "$HOME/code"
default asroot "sudo"

mkdir -p "$workdir"

# setup config
mkdir -p ~/.config/nvim
ln -sf "$PWD/nvim" ~/.config/nvim

echo "setup alacritty config"
mkdir "$HOME/.config/alacritty"
ln -sf "$PWD/alacritty.toml" ~/.config/alacritty/commonconfig.toml
alacritty_majro_version=$(alacritty --version | cut -d' ' -f2 | cut -d. -f2)
if [ $alacritty_majro_version -ge "14" ] ; then
	echo "[general]" > ~/.config/alacritty/alacritty.toml
else
	:> ~/.config/alacritty/alacritty.toml
fi
echo "live_config_reload = true" >> ~/.config/alacritty/alacritty.toml
echo "import = [ '~/.config/alacritty/commonconfig.toml' ]" >> ~/.config/alacritty/alacritty.toml

echo "setup shrc.sh symlink"
ln -sf "$PWD/bashrc" ~/.shrc.sh

echo "setup shenv.sh file"
echo "# this computer's env file" > ~/.shenv.sh
echo "## file generated by dots/setup.sh" >> ~/.shenv.sh

read -e -p "link tmpl-rs files? [y/N]>" -n 1 usi
if [[ $usi == "y" ]] ; then
	if [ "$TMPLRS_DIR" = "" ] ; then
		#TODO: check with user for another dir
		read -e -p "use $PWD/tmpl-rs as tmpl-rs' template dir? [Y/n]>" -n 1 usi
		if [[ $usi == "n" ]] ; then
			read -e -p "set tmpl-rs template dir>" TMPLRS_DIR
		else
			TMPLRS_DIR="$PWD/tmpl-rs"
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

	ln -sf "$PWD/tmpl-rs" "$TMPLRS_DIR"
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
	read -e -p "download github.com/pedromanse/devaps? [y/N]>" -n 1 usi
	if [[ $usi == "y" ]] ; then
		echo "cloning to $workdir/devaps"
		cloneat devaps pedromanse "$workdir/devaps"
		echo "export DEVAPS=\"${workdir}/devaps\"" >> ~/.shenv.sh
	fi
else
	echo "export DEVAPS=\"${workdir}/devaps\"" >> ~/.shenv.sh
fi

for pid in $jbs; do
	wait $pid
done

cd $back
