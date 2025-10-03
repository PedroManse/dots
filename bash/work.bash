#! /usr/bin/env bash
DIARY_REPO="$HOME/diary"
DEFAULT_LOG_NAME="work"

function work {
	pushd "$DIARY_REPO"
	git pull
	if [ ! -z "$1" ] ; then
		$EDITOR "$1"
	else
		$EDITOR "$DEFAULT_LOG_NAME"
	fi
	gitmsg=$(date +'%d/%mT%H:%M')
	git commit -am "$gitmsg" -m "\nautomatic commit"
	git push
	popd
}

