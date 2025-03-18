set -e
proj_name=$1

cargo new --bin $proj_name
cd $proj_name
echo "target" >> .gitignore
echo ".direnv" >> .gitignore

echo """{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShellNoCC {
    nativeBuildInputs = with pkgs.buildPackages; [ ];
}
""" > shell.nix
echo "use nix" > .envrc

log=$(mktemp)
crate_name=""
echo "create project $proj_name" > $log
features=""
for arg in "${@:2}" "" ; do
	if [[ "$arg" =~ "-" ]] then
		features="$features${arg#-} "
	elif [ -z "$crate_name" ] ; then
		# first crate
		# consume last " "
		crate_name=$arg
	else
		if [ -z "$features" ] ; then
			echo "add $crate_name with default features" >> $log
			cargo add $crate_name
		else
			echo "add $crate_name with [ $features]" >> $log
			cargo add $crate_name --features $features
		fi
		features=""
		crate_name=$arg
	fi
done

cat $log
rm $log
