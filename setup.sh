#! /bin/bash
set -e

workdir="$HOME/code"
mkdir -p "$workdir"

# couldn't import the config with home-manager
# nvim setup config
mkdir -p ~/.config/nvim
ln -sf "$PWD/nvim" ~/.config/nvim

# shenv config
echo "setup shenv.sh file"
echo "# this computer's env file" > ~/.shenv.sh
echo "## file generated by dots/setup.sh" >> ~/.shenv.sh
echo "export TMPLRS_DIR=\"$PWD/tmpl-rs\"" >> ~/.shenv.sh

# download devaps
if [ ! -d "$workdir/devaps" ] ; then
	read -e -p "download github.com/pedromanse/devaps? [y/N]>" -n 1 usi
	if [[ $usi == "y" ]] ; then
		echo "cloning to $workdir/devaps"
		git clone "https://github.com/PedroManse/devaps" "$workdir/devaps"
		echo "export DEVAPS=\"${workdir}/devaps\"" >> ~/.shenv.sh
	fi
else
	echo "export DEVAPS=\"${workdir}/devaps\"" >> ~/.shenv.sh
fi


set -xe
sudo ln -sf "$PWD/nix/configuration.nix" /etc/nixos/configuration.nix
